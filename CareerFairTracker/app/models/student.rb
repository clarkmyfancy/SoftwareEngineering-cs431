class Student < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :event, optional: true

    def self.to_csv
        attributes = %w(first_name last_name major)

        CSV.generate(headers: true) do |csv|
            csv << attributes

            all.each do |student|
                csv << student.attributes.values_at(*attributes)
            end
        end
    end
end
