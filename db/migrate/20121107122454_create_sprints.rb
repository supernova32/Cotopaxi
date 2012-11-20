# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  Patricio Cano
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :duration
      t.integer :project_id, null: false
      t.integer :number, default: 1
      t.string  :state, default: "created"

      t.timestamps
    end
  end
end
