# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091216125726) do

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "slug"
  end

  add_index "products", ["created_at"], :name => "index_products_on_created_at"
  add_index "products", ["creator_id"], :name => "index_products_on_creator_id"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["owner"], :name => "index_products_on_owner"
  add_index "products", ["slug"], :name => "index_products_on_slug"
  add_index "products", ["updated_at"], :name => "index_products_on_updated_at"
  add_index "products", ["updater_id"], :name => "index_products_on_updater_id"

  create_table "sprints", :force => true do |t|
    t.string   "name"
    t.integer  "estimated_velocity"
    t.integer  "velocity"
    t.date     "start"
    t.date     "end"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "sprints", ["created_at"], :name => "index_sprints_on_created_at"
  add_index "sprints", ["creator_id"], :name => "index_sprints_on_creator_id"
  add_index "sprints", ["end"], :name => "index_sprints_on_end"
  add_index "sprints", ["estimated_velocity"], :name => "index_sprints_on_estimated_velocity"
  add_index "sprints", ["name"], :name => "index_sprints_on_name"
  add_index "sprints", ["product_id"], :name => "index_sprints_on_product_id"
  add_index "sprints", ["start"], :name => "index_sprints_on_start"
  add_index "sprints", ["updated_at"], :name => "index_sprints_on_updated_at"
  add_index "sprints", ["updater_id"], :name => "index_sprints_on_updater_id"
  add_index "sprints", ["velocity"], :name => "index_sprints_on_velocity"

  create_table "stories", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.text     "description"
    t.integer  "estimative"
    t.integer  "priority"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "stories", ["color"], :name => "index_stories_on_color"
  add_index "stories", ["created_at"], :name => "index_stories_on_created_at"
  add_index "stories", ["creator_id"], :name => "index_stories_on_creator_id"
  add_index "stories", ["estimative"], :name => "index_stories_on_estimative"
  add_index "stories", ["name"], :name => "index_stories_on_name"
  add_index "stories", ["priority"], :name => "index_stories_on_priority"
  add_index "stories", ["product_id"], :name => "index_stories_on_product_id"
  add_index "stories", ["updated_at"], :name => "index_stories_on_updated_at"
  add_index "stories", ["updater_id"], :name => "index_stories_on_updater_id"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "status"
    t.integer  "estimative"
    t.integer  "story_id"
    t.integer  "sprint_id"
    t.boolean  "unplanned"
    t.datetime "status_changed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "tasks", ["created_at"], :name => "index_tasks_on_created_at"
  add_index "tasks", ["creator_id"], :name => "index_tasks_on_creator_id"
  add_index "tasks", ["estimative"], :name => "index_tasks_on_estimative"
  add_index "tasks", ["name"], :name => "index_tasks_on_name"
  add_index "tasks", ["sprint_id"], :name => "index_tasks_on_sprint_id"
  add_index "tasks", ["status"], :name => "index_tasks_on_status"
  add_index "tasks", ["status_changed_at"], :name => "index_tasks_on_status_changed_at"
  add_index "tasks", ["story_id"], :name => "index_tasks_on_story_id"
  add_index "tasks", ["unplanned"], :name => "index_tasks_on_unplanned"
  add_index "tasks", ["updated_at"], :name => "index_tasks_on_updated_at"
  add_index "tasks", ["updater_id"], :name => "index_tasks_on_updater_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.datetime "last_login_at"
    t.integer  "login_count"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

end
