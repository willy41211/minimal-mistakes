#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"
require "fileutils"
require "date"

DATA_FILE = File.expand_path("../_data/restaurants.yml", __dir__)
OUTPUT_DIR = File.expand_path("../_restaurants", __dir__)

restaurants = YAML.safe_load(File.read(DATA_FILE), permitted_classes: [Date])
FileUtils.mkdir_p(OUTPUT_DIR)

restaurants.each do |restaurant|
  record = restaurant.dup
  body = record.delete("body") || ""
  slug = (record["slug"] || record["name"]).to_s
  slug = slug.downcase.gsub(/[^a-z0-9\-\p{Alnum}_]+/i, "-").gsub(/-{2,}/, "-").gsub(/^-|-$|_+/, "")

  front_matter = record.merge(
    "layout" => "restaurant",
    "title" => record["name"],
    "permalink" => record.fetch("permalink", "/restaurants/#{slug}/"),
  )

  file_path = File.join(OUTPUT_DIR, "#{slug}.md")
  File.open(file_path, "w") do |file|
    file.puts(front_matter.to_yaml)
    file.puts("---")
    file.puts
    file.puts(body.rstrip)
    file.puts
  end
end
