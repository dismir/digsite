# frozen_string_literal: true

module DataMappers
  class Excavator < DataMappers::Base
    private

    def attributes
      {
        company_name: params['CompanyName'],
        address: address,
        crew_on_site: crew_on_site
      }
    end

    def address
      {
        street: params['Address'],
        city: params['City'],
        state: params['State'],
        zip: params['Zip'],
        contact: {
          name: params['Contact']['Name'],
          phone: params['Contact']['Phone'],
          email: params['Contact']['Email']
        },
        field_contact: {
          name: params['FieldContact']['Name'],
          phone: params['FieldContact']['Phone'],
          email: params['FieldContact']['Email']
        }
      }
    end

    def crew_on_site
      return true if params['CrewOnsite'] == true

      false
    end
  end
end
