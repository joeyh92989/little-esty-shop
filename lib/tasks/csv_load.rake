require 'CSV'
require 'benchmark'

namespace :csv_load do
  desc 'importing customers from csv file'
    task customers: :environment do
      puts 'resetting database'
      Customer.destroy_all
      puts 'database successfully deleted'
      puts 'loading data...'
      time = Benchmark.realtime do
        CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Customer.create(row.to_hash)
        end
      end

      puts "Added #{Customer.count}  in #{time} seconds"

      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end
  desc 'importing invoice_items from csv file'
    task invoice_items: :environment do
      puts 'resetting database'
      InvoiceItem.destroy_all
      puts 'database successfully deleted'
      puts 'loading data...'
      time = Benchmark.realtime do
        CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          InvoiceItem.create(row.to_hash)
        end
      end

      puts "Added #{InvoiceItem.count}  in #{time} seconds"

      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end
  desc 'importing invoices from csv file'
    task invoices: :environment do
      puts 'resetting database'
      Invoice.destroy_all
      puts 'database successfully deleted'
      puts 'loading data...'
      time = Benchmark.realtime do
        CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Invoice.create(row.to_hash)
        end
      end

      puts "Added #{Invoice.count}  in #{time} seconds"

      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end
  desc 'importing items from csv file'
    task items: :environment do
      puts 'resetting database'
      Item.destroy_all
      puts 'database successfully deleted'
      puts 'loading data...'
      time = Benchmark.realtime do
        CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Item.create(row.to_hash)
        end
      end

      puts "Added #{Item.count}  in #{time} seconds"

      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end
  desc 'importing merchants from csv file'
    task merchants: :environment do
      puts 'resetting database'
      Merchant.destroy_all
      puts 'database successfully deleted'
      puts 'loading data...'
      time = Benchmark.realtime do
        CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Merchant.create(row.to_hash)
        end
      end

      puts "Added #{Merchant.count}  in #{time} seconds"

      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end
  desc 'importing transactions from csv file'
    task transactions: :environment do
      puts 'resetting database'
      Transaction.destroy_all
      puts 'database successfully deleted'
      puts 'loading data...'
      time = Benchmark.realtime do
        CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Transaction.create!(row.to_hash)
        end
      end

      puts "Added #{Transaction.count}  in #{time} seconds"

      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end

  desc 'importing transactions from csv file'
    task all: :environment do
      puts 'resetting database'
      InvoiceItem.destroy_all
      Transaction.destroy_all
      Item.destroy_all
      Invoice.destroy_all
      Customer.destroy_all
      Merchant.destroy_all
      puts 'database successfully deleted'
      puts 'loading data...'
      time = Benchmark.realtime do
        CSV.foreach("db/data/merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Merchant.create!(row.to_hash)
        end
        CSV.foreach("db/data/customers.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Customer.create!(row.to_hash)
        end
        CSV.foreach("db/data/invoices.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Invoice.create!(row.to_hash)
        end
        CSV.foreach("db/data/items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Item.create!(row.to_hash)
        end
        CSV.foreach("db/data/transactions.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          Transaction.create!(row.to_hash)
        end
        CSV.foreach("db/data/invoice_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
          InvoiceItem.create!(row.to_hash)
        end
      end

      puts "Added #{(Merchant.count) + (Customer.count) +(Invoice.count) +(Item.count) +(Transaction.count) + InvoiceItem.count}  in #{time} seconds"

      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end
end
