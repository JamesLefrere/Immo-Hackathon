//tealium universal tag - utag.5 ut4.0.201407021258, Copyright 2014 Tealium.com Inc. All Rights Reserved.
try{(function(id,loader,u){try{u=utag.o[loader].sender[id]={}}catch(e){u=utag.sender[id]};u.ev={'view':1};u.cnv_label='X85YCJ2AmQQQg5TU_AM';u.cnv_id='1066732035';u.base_url="//googleads.g.doubleclick.net/pagead/viewthroughconversion/";u.map={"pag_pagetitle":"google_custom_params.page"};u.extend=[];u.send=function(a,b,c,d,e,f){if(u.ev[a]||typeof u.ev.all!='undefined'){var g=[];c=[];for(d in utag.loader.GV(u.map)){if(typeof b[d]!='undefined'&&b[d]!=''){e=u.map[d].split(',');for(f=0;f<e.length;f++){if(e[f]=='google_conversion_label'){u.cnv_label=b[d];}else if(e[f]=='google_conversion_id'){u.cnv_id=b[d];}else{g.push(e[f].replace("google_custom_params.","")+"="+b[d]);}}}}
u.data=((g.length>0)?"&data="+encodeURIComponent(g.join(";")):"");u.cnv_label=u.cnv_label.replace(/\s+/g,"");c=u.cnv_label.split(",");u.cnv_id=u.cnv_id.replace(/\s+/g,"");e=u.cnv_id.split(",");for(f=0;f<c.length;f++){u.cnv_val="0"||b._csubtotal||"";var i=new Image();i.src=u.base_url+(e[f]?e[f]:e[0])+"/?"+(u.cnv_val?"value="+u.cnv_val+"&":"")+"label="+c[f]+"&guid=ON&script=0"+u.data;}}}
try{utag.o[loader].loader.LOAD(id)}catch(e){utag.loader.LOAD(id)}})('5','immobilienscout.is24');}catch(e){}
