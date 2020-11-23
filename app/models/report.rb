class Report < ActiveRecord::Base
  
  def self.one_reader(from, to)
    
   result = 0
   res =  ActiveRecord::Base.connection.execute("select count(r.id) from readers as r, payments as p where r.id = p.reader_id and p.created_at between '" + from.to_s + " 00:00' and '" + to.to_s + " 23:59';")
   res.each{ |r|
       result = r[0]
   }

   result
 end

 def self.catered_reader(from, to)

   hash = Hash.new

   res =  ActiveRecord::Base.connection.execute("select count(distinct r.id), d.id from readers as r, checklists as s, checklist_values as v, sectors ss, departments d where r.id = s.reader_id and s.id = v.checklist_id and d.id = ss.department_id and v.sector_id = ss.id and s.created_at between '" + from.to_s + " 00:00' and '" + to.to_s + " 23:59' group by d.id; ")
   res.each{ |r|
       hash[r[1]] = r[0]
   }
   hash
 end

 def self.visiting(from, to)
   hash = Hash.new

   res =  ActiveRecord::Base.connection.execute("select count(distinct s.id) as sid, d.id from readers as r, checklists as s, checklist_values as v, sectors ss, departments d where r.id = s.reader_id and s.id = v.checklist_id and d.id = ss.department_id and v.sector_id = ss.id and s.created_at between '" + from.to_s + " 00:00' and '" + to.to_s + " 23:59' group by ss.id;")
   res.each{ |r|
      hash[r[1]].nil? ? hash[r[1]] = r[0].to_i : hash[r[1]] += r[0].to_i
   }

   events_count = ActiveRecord::Base.connection.execute("select sum(e.count), d.id from departments as d, departments_events as de, events as e where d.id = de.department_id and de.event_id = e.id and e.created_at between '" + from.to_s + " 00:00' and '" + to.to_s + " 23:59' group by d.id;")

   events_count.each{|ec|
    hash.key?(ec[1]) ? hash[ec[1]] += ec[0].to_i : hash[ec[1]] = ec[0].to_i 
   }

   hash
 end

 def self.bookkeeping(from, to)
   data = Hash.new

   res =  ActiveRecord::Base.connection.execute("select sum(v.value), ss.id, b.id from readers as r, checklists as s, checklist_values as v, sectors ss, departments d, brunches b where r.id = s.reader_id and s.id = v.checklist_id and d.id = ss.department_id and v.sector_id = ss.id and b.id = v.brunch_id and s.created_at between '" + from.to_s + " 00:00' and '" + to.to_s + " 23:59' group by b.id, ss.id;")
   res.each{ |r|
       data[r[1].to_s + "%" +r[2].to_s] =  r[0]
   }

   data
 end

 def self.brunches_report(from, to)
   data = self.bookkeeping(from, to)

   departments = Department.find(:all, :order => "id ASC")
   brunches = Brunch.find(:all, :order => "id ASC")

   a = 0; k = 0; j = 0; all_sum = 0; i = 0; temp = 0; brunch_sum = 0;
   hash = Hash.new

   while a < departments.length
     length = departments[a].sectors.length
     while k <= length
       sum = 0
       unless k == length

        data.each do |key, value|
          dep_id = key.gsub(/%\d+$/){ $1 }
          brunch_id = key.gsub(/^\d+%/){ $1 }
          if dep_id == departments[a].sectors[k].id.to_s && brunch_id.to_i <= 7
            sum += value.to_i
          end
        end

        hash[i] = []
        while j < brunches.length

          if departments[a].id == 2 && departments[a].sectors[k].id == 3 && brunches[j].id == 9
            hash[i].push(sum)
          else
            value = data["#{departments[a].sectors[k].id.to_s}%#{brunches[j].id.to_s}"]
            value.nil? ? hash[i].push(0) : hash[i].push(value.to_i)
          end
          j += 1
        end
        j = 0
        
      else

        if length > 1
          hash[i] = []
          while j < brunches.length
            iter = length
            while iter > 0
              temp += hash[i - iter][j]
              iter -= 1
            end
            hash[i].push(temp)
            if brunches[j].id <= 7
              sum += temp
            end
            temp = 0
            j += 1
          end
        end

        j = 0

      end

      unless length == 1 && k == length
        hash[i].push(sum)
        i += 1;
      end

      unless length > 1 && k < length
        all_sum += sum
      end
      k += 1
     end
     k = 0
     a += 1
   end
   hash[i] = []
   brunches.each do |b|

     data.each do |key, value|
       brun_id = key.scan(/\d+/)[1]
       if brun_id.to_i == b.id
         brunch_sum += value.to_i
       end
     end

     hash[i].push(brunch_sum)
     brunch_sum = 0

   end
   hash[i].push(all_sum)

   hash
 end

  def self.payments_report(from, to)
   sum = 0

   res =  ActiveRecord::Base.connection.execute("select sum(money_sum) from payments as p where p.created_at between '" + from.to_s + " 00:00' and '" + to.to_s + " 23:59';")
   res.each{ |r|
      sum = r[0]
   }

   sum
  end
end
