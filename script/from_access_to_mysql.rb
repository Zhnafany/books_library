#!/usr/bin/ruby -w

require 'rubygems'
require 'mysql'


   begin
     # connect to the MySQL server
     main_db = Mysql.real_connect("localhost", "root", "root", "demolibrary")
     access_db = Mysql.real_connect("localhost", "root", "root", "library_development")

#     get server version string and display it
#     puts "Server version: " + dbh.get_server_info
#     puts "Server version: " + dbh.get_server_info
   rescue Mysql::Error => e
     puts "Error code: #{e.errno}"
     puts "Error message: #{e.error}"
     puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
   ensure
     array = Array.new
     array.push main_db
     array.push access_db
     array.each{|db| 
	     db.query("set character_set_client  = 'utf8'")
	     db.query("set character_set_connection  = 'utf8'")
	     db.query("set character_set_database  = 'utf8'")
	     db.query("set character_set_results  = 'utf8'")
     }
     # parse streets
     result = access_db.query("SELECT id, caption FROM dir_streets")
	

     result.each{|row|
     begin
         main_db.query("INSERT INTO streets (id, name) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}')")
	rescue
	end
     }

      
     # parse cities
     result = access_db.query("SELECT id, caption FROM dir_cities")

     result.each{|row|
	begin
         main_db.query("INSERT INTO cities (id, name) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}')")
	rescue
	end
     }
	
    # parse work_places
    result = access_db.query("SELECT id, caption FROM dir_workplaces")

     result.each{|row|
	begin
         main_db.query("INSERT INTO work_places (id, name) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}')")
	rescue
	end
     }

     # parse faculties
     result = access_db.query("SELECT id, vuz_id, caption, short FROM dir_faculties")

     result.each{|row|
	begin
         main_db.query("INSERT INTO faculties (id, name, vuz_id, description) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row	     [3])}', '#{main_db.escape_string(row[1])}', '#{main_db.escape_string(row[2])}')")
	rescue
	end
     }

    # parse educational_institution
    result = access_db.query("SELECT id, caption, short FROM dir_vuz")

    result.each{|row|
	begin
         main_db.query("INSERT INTO educational_institutions (id, name, description) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[2])}', '#{main_db.escape_string(row[1])}')")
	rescue
	end
    }

    # parse regions
    result = access_db.query("SELECT id, caption FROM dir_regions")

    result.each{|row|
	begin
        main_db.query("INSERT INTO regions (id, name) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}')")
	rescue
	end
    }

    # parse readers
    result = access_db.query("SELECT * FROM readers")

   debtor = :ні
    result.each{|row|
	begin
	if row[6].to_i == 1 then 
		document_type = 'паспорт'
		document_num = row[7] + row[8]	
	 elsif row[6].to_i == 2 then
		document_type = 'студен. квиток'
		document_num = row[9] + row[10] 
	end
	if row[25].to_i == 1 then 
		const_work_place = 'так'
	elsif row[25].to_i == 0
		const_work_place = 'ні'
	end
	[row[1],row[2],row[3]].each{|str|
		str.gsub!(/[\']+/){ '\\\''} unless str.nil? 
	}
	row[16].gsub!(/\\$/){'\\\\'} unless row[16].nil?
 	main_db.query("INSERT INTO readers (id, surname, name, father_name, birthdate, document_type, document_num, category_id, degree_id, educational_institution_id, faculty_id, course, status_id, benefit_id, created_at, debtor) VALUES ('#{ row[0]}', '#{ row[1]}', '#{ row[2]}', '#{ row[3]}', '#{ row[4]}', '#{ document_type}', '#{ document_num}', '#{ row[26]}', '#{ row[27]}', '#{ row[28]}', '#{ row[29]}', '#{ row[30]}', '#{ row[32]}', '#{ row[39]}', '#{ row[5]}', '#{ debtor}')")

	main_db.query("INSERT INTO contacts (region_id, city_id, street_id, house_number, flat_number, post_code, phone1, phone2, phone3, e_mail1,          work_place_id, const_work_place, reader_id) VALUES ('#{row[11]}', '#{ row[13]}', '#{ row[14]}', '#{ row[16]}', '#{ row[18]}', '#{ row[19]}', '#{ row[20]}', '#{ row[21]}', '#{ row[22]}', '#{ row[23]}', '#{ row[24]}', '#{ const_work_place}', '#{ row[0]}')")
	rescue
	end
    }

    # parse benefits
    result = access_db.query("SELECT id, caption, discount FROM dir_benefits")

    result.each{|row|
	begin
        main_db.query("INSERT INTO benefits (id, description, discount) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}', '#{main_db.escape_string(row[2])}')")
	rescue
	end
    }

# parse categories
   result = access_db.query("SELECT id, code, caption FROM dir_reader_cats")

    result.each{|row|
	begin
        main_db.query("INSERT INTO categories (id, code, description) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}', '##  {main_db.escape_string(row[2])}')")
	rescue
	end
    }
	
# parse degrees
    result = access_db.query("SELECT id, caption FROM dir_education")

   result.each{|row|
        main_db.query("INSERT INTO degrees (id, degree) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}')")
    }

# parse statuses
    result = access_db.query("SELECT id, caption FROM dir_reader_status")

   result.each{|row|
        main_db.query("INSERT INTO statuses (id, description) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}')")
    }

# parse sectors
    result = access_db.query("SELECT id, department_id, short FROM dir_sectors")

   result.each{|row|
        main_db.query("INSERT INTO sectors (id, department_id, name) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}', '#{main_db.escape_string(row[2])}')")
    }

 parse departments
    result = access_db.query("SELECT id, short FROM dir_departments")

   result.each{|row|
        main_db.query("INSERT INTO departments (id, name) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}')")
    }

# parse brunces
 result = access_db.query("SELECT id, short FROM dir_brunches")

   result.each{|row|
        main_db.query("INSERT INTO brunches (id, name) VALUES ('#{main_db.escape_string(row[0])}', '#{main_db.escape_string(row[1])}')")
    }

# parse payments
     result = access_db.query("SELECT id, ticket_no, date, user_name, total, benefit_id FROM payments")

	result.each{|row|
		row[3] = "" if row[3].nil?
		row[5] = 0 if row[5].nil?
		row[4] = 0 if row[4].nil?
		main_db.query("INSERT INTO payments (id, reader_id, created_at, user_name, money_sum, benefit_id) VALUES ('#{main_db.escape_string(row[0])}', '#{row[1]}', '#{main_db.escape_string(row[2])}', '#{main_db.escape_string(row[3])}', '#{row[4]}', '#{row[5]}')")
	    }     
	
     # disconnect from server
     main_db.close if main_db
     access_db.close if access_db
   end

