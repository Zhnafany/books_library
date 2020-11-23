update sectors set id = 0 where id = 1;
update sectors set id = 1 where id = 2;
update sectors set id = 2 where id = 0;

update checklist_values set sector_id = 0 where sector_id = 2;
update checklist_values set sector_id = 2 where sector_id = 1;
update checklist_values set sector_id = 1 where sector_id = 0;
