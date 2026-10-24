#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

query="SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type
FROM elements e
JOIN properties p ON e.atomic_number = p.atomic_number
JOIN types t ON p.type_id = t.type_id
WHERE CAST(e.atomic_number AS text) = '$1'
   OR LOWER(e.symbol) = LOWER('$1')
   OR LOWER(e.name) = LOWER('$1');"

result=$(psql -X -t -A -d periodic_table -U postgres -h localhost -c "$query" 2>/dev/null)

if [[ -z "$result" ]]; then
  echo "I could not find that element in the database."
  exit 0
fi

IFS='|' read -r atomic_number symbol name atomic_mass melting_point boiling_point type <<< "$result"

printf "The element with atomic number %s is %s (%s). It's a %s, with a mass of %s amu. %s has a melting point of %s celsius and a boiling point of %s celsius.\n" \
  "$atomic_number" "$name" "$symbol" "$type" "$atomic_mass" "$name" "$melting_point" "$boiling_point"
