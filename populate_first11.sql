create or replace procedure populate_first11 as
    type vector is table of int;
    cursor c_play is select * from play;
    id_first11 integer;
    id_match integer;
    c_gk vector;
    c_lb_lwb vector;
    c_cb  vector;
    c_rb_rwb vector;
    c_cm_cdm vector;
    c_lm_lw vector;
    c_rm_rw vector;
    c_cf_cam vector;
begin
    id_first11:=1;
    for v_play in c_play loop
        id_match:=v_play.ID_MATCH;
        select id_player bulk collect into c_gk from player where id_team=v_play.ID_TEAM and position='GK';
        select id_player bulk collect into c_lb_lwb from player where id_team=v_play.ID_TEAM and (position='LB' or position='LWB');
        select id_player bulk collect into c_cb from player where id_team=v_play.ID_TEAM and position='CB';
        select id_player bulk collect into c_rb_rwb from player where id_team=v_play.ID_TEAM and (position='RB' or position='RWB');
        select id_player bulk collect into c_cm_cdm from player where id_team=v_play.ID_TEAM and (position='CM' or position='CDM');
        select id_player bulk collect into c_lm_lw from player where id_team=v_play.ID_TEAM and (position='LM' or position='LW');
        select id_player bulk collect into c_rm_rw from player where id_team=v_play.ID_TEAM and (position='RM' or position='RW');
        select id_player bulk collect into c_cf_cam from player where id_team=v_play.ID_TEAM and (position='CF' or position='CAM');
        declare
            random int;
            random1 int;
            id_player int;
        begin
            random:=trunc(dbms_random.value(c_gk.FIRST,c_gk.LAST+1));
            id_player:=c_gk(random);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random:=trunc(dbms_random.value(c_lb_lwb.FIRST,c_lb_lwb.LAST+1));
            id_player:=c_lb_lwb(random);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random:=trunc(dbms_random.value(c_cb.FIRST,c_cb.LAST+1));
            id_player:=c_cb(random);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random1:=trunc(dbms_random.value(c_cb.FIRST,c_cb.LAST+1));
            while random = random1 loop
                random1:=trunc(dbms_random.value(c_cb.FIRST,c_cb.LAST+1));
            end loop;
            id_player:=c_cb(random1);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random:=trunc(dbms_random.value(c_rb_rwb.FIRST,c_rb_rwb.LAST+1));
            id_player:=c_rb_rwb(random);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random:=trunc(dbms_random.value(c_cm_cdm.FIRST,c_cm_cdm.LAST+1));
            id_player:=c_cm_cdm(random);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random1:=trunc(dbms_random.value(c_cm_cdm.FIRST,c_cm_cdm.LAST+1));
            while random = random1 loop
                random1:=trunc(dbms_random.value(c_cm_cdm.FIRST,c_cm_cdm.LAST+1));
            end loop;
            id_player:=c_cm_cdm(random1);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random:=trunc(dbms_random.value(c_lm_lw.FIRST,c_lm_lw.LAST+1));
            id_player:=c_lm_lw(random);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random:=trunc(dbms_random.value(c_rm_rw.FIRST,c_rm_rw.LAST+1));
            id_player:=c_rm_rw(random);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random:=trunc(dbms_random.value(c_cf_cam.FIRST,c_cf_cam.LAST+1));
            id_player:=c_cf_cam(random);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;

            random1:=trunc(dbms_random.value(c_cf_cam.FIRST,c_cf_cam.LAST+1));
            while random = random1 loop
                random1:=trunc(dbms_random.value(c_cf_cam.FIRST,c_cf_cam.LAST+1));
            end loop;
            id_player:=c_cf_cam(random1);
            insert into first11 values (id_first11,id_player,id_match);
            id_first11:=id_first11+1;
        end;
    end loop;
end;