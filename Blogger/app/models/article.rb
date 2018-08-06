class Article < ApplicationRecord
    has_many :comments
    has_many :taggings
    has_many :tags, through: :taggings

    def tag_list
        # Coba `self.tags.pluck(:name).join(', ')`.
        # Bedanya `pluck` dengan `collect`: dengan `pluck` kita langsung mengambil
        # name nya saja dari database, sedangkan dengan `collect`, kita ambil
        # semuanya, kemudian kita proses di dalam memori.
        self.tags.collect do |tag|
            tag.name
        end.join(", ")
    end

    def tag_list=(tags_string)
        tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
        new_or_found_tags = tag_names.collect{|name| Tag.find_or_create_by(name: name)}
        self.tags = new_or_found_tags
    end
end
