class Free_slot

    def self.find_free_slot(google_cal,ical)
        cal=google_cal+ical   
        free_slot=[]
        sort_cal=cal.sort_by { |k| k[:start] }.uniq
        for i in 0..sort_cal.size-1
            timeslot=sort_cal[0]
            free_slot.push(timeslot)
            sort_cal.delete_if{ |time| time[:end]<=timeslot[:end]} 
            if sort_cal.empty?
                break
            end
            
        end
        puts "#{free_slot}"
    end
end

google_cal=[{start: "2015-11-01T10:00:00.00+08:00",end: "2015-11-01T11:00:00.00+08:00"},{start: "2015-11-01T11:00:00.00+08:00",end: "2015-11-01T14:00:00.00+08:00"},{start: "2015-11-01T15:00:00.00+08:00",end: "2015-11-01T17:00:00.00+08:00"}]
ical=[{start: "2015-11-01T12:00:00.00+08:00",end: "2015-11-01T13:00:00.00+08:00"},{start: "2015-11-01T13:00:00.00+08:00",end: "2015-11-01T14:00:00.00+08:00"},{start: "2015-11-01T14:00:00.00+08:00",end: "2015-11-01T15:00:00.00+08:00"},{start: "2015-11-01T15:00:00.00+08:00",end: "2015-11-01T16:00:00.00+08:00"}]

Free_slot.find_free_slot(google_cal,ical)