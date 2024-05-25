class UserMailer < ApplicationMailer
    default from: 'no-replay@no-replay.com'

    require 'csv'
    

    def balance_report(user)

        @user = user

        @people = Person.order(:name)

        csv_content = generate_csv_file()

        attachments['relatorio_balanco.csv'] = { mime_type: 'text/csv', content: csv_content }
    
        mail(to: user.email, subject: 'Relatório de balanço Ledger', attachments:attachments )
    end

    def generate_csv_file
        CSV.generate(headers: true) do |csv|
            # CSV Header Row
            csv << ['Nome', 'Saldo']

            # CSV Rows, each row representing a transaction
            @people.each do |person|
                csv << [
                    person.name,
                    person.balance
                ]
            end
        end
    end
    

end
