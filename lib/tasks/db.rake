namespace :db do

  # desc 'Move service agreements to their own table'
  # task move_agreements: :environment do
  #   Organization.all.each do |org|
  #
  #     if org.service_agreement.file
  #       agreement = org.agreements.build(agreement: org.service_agreement)
  #       if agreement.save
  #         puts '.'
  #       else
  #         puts "Record: #{agreement}, Errors: #{agreement.errors.full_messages}"
  #       end
  #     end
  #
  #   end
  # end

  # desc 'Remove corrupted agreements'
  # task remove_corrupt: :environment do
  #   Agreement.all.each do |agreement|
  #     if %W[ SAAgreement20-08-15T1500.pdf SAAgreement20-08-15T1501.pdf SAAgreement20-08-15T1502.pdf  ].include? agreement.agreement.file.filename
  #       agreement.destroy
  #     end
  #   end
  # end

end
