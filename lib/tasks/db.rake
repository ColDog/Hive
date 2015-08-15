namespace :db do

  desc 'Move service agreements to their own table'
  task move_agreements: :environment do
    Organization.all.each do |org|
      if org.service_agreement
        agreement = org.agreements.build(agreement: org.service_agreement, name: 'Agreement')
        if agreement.save
          puts '.'
          org.update(service_agreement: nil)
        else
          puts "Record: #{agreement}, Errors: #{agreement.errors.full_messages}"
        end
      end
    end
  end

end
