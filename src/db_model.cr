require "db"
require "json"

macro db_model(name, *properties)
  {% for p in properties %}
    {% if !p.is_a?(TypeDeclaration) %}
      raise "ERROR: Only type declaration is accepted for db_model"
    {% end %}
  {% end %}

    record {{name.id}}, {{*properties}} do
    
    JSON.mapping(
      {% for p in properties %}
        {{p.var}}: {{p.type}},
      {% end %}
    )

    def self.query(db, q : String)
      models = [] of self

      db.query(q) do |rows|
        rows.each do
          models << read(rows)
        end
      end
      models
    end

    def self.read(row)
      new(
        {% for p in properties %}
          {% if p.is_a?(TypeDeclaration) %}
            row.read({{p.type}}).as({{p.type}}),
          {% end %}
        {% end %}
      )
    end
  end
end
