# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_213_141_614) do # rubocop:disable Metrics/BlockLength
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'application_settings', force: :cascade do |t|
    t.integer 'minimal_deposit', default: 200
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'user_settings', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.integer 'status', default: 0
    t.integer 'language', default: 0
    t.boolean 'deposit_required', default: true
    t.json 'comment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_user_settings_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'phone'
    t.string 'first_name'
    t.string 'last_name'
    t.string 'encrypted_password'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'account_type', default: 'visitor', null: false
    t.datetime 'remember_created_at'
    t.datetime 'last_visit'
    t.integer 'points', default: 0, null: false
  end

  create_table 'visits', force: :cascade do |t|
    t.bigint 'visitor_id', null: false
    t.bigint 'employee_id', null: false
    t.integer 'payment_status', default: 0
    t.datetime 'visit_date', null: false
    t.string 'comment'
    t.json 'conclusion'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['employee_id'], name: 'index_visits_on_employee_id'
    t.index ['visitor_id'], name: 'index_visits_on_visitor_id'
  end

  add_foreign_key 'user_settings', 'users'
  add_foreign_key 'visits', 'users', column: 'employee_id'
  add_foreign_key 'visits', 'users', column: 'visitor_id'
end
