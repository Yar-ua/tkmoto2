class CreateStataRepairs < ActiveRecord::Migration[5.0]
  def change
    create_table :stata_repairs do |t|

      t.string		:type	# тип: ремонт/апгрейд/комплектующие
      t.string		:note	# примечания
      t.numeric		:price	# стоимость, грн
      t.references	:bike # , foreign_key: true

      t.timestamps
    end
  end
end
