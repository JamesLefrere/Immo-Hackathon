var utag_data = {"clientId":"a-f194fe44062248249d41ebdc069ea4d2","mpl":"is24","content":"dyn","dg2":"wohnen","dg1":"m","dg3":"wohnung_miete","psn_iphash":"4b0805c6b70bac828efe88dcaea9ea8408cb23804ec3454970ffc05dc32d0ab2","geo_bln":["berlin"],"label_ux":"navi_alt","mpln":"is24","svc_module_name":"mobile","svc_tm_version":"V1.79","pag_pagetitle":"is24.de.m.wohnen.wohnung_miete.expose","obj_ityp":["wohnung_miete"],"geo_krs":["berlin"],"portal":"next","geo_land":["deutschland"],"evt_event":["06"]};
/*jslint browser: true, plusplus: true, regexp: true, vars: true, white: true, bitwise: true, sloppy: false*/
/*global IS24, utag_data, escape*/
//http://jslint.com/

window.IS24 = window.IS24 || {};

IS24.registerNS = function (ns) {
	"use strict";

	var i,
        nsParts = ns.split("."),
        root = window;
    
    for (i = 0; i < nsParts.length; i++) {
        if (root[nsParts[i]] === undefined) {
            root[nsParts[i]] = {};
        }
        root = root[nsParts[i]];
    }
};

IS24.registerNS("IS24.TEALIUM.cookie");

IS24.TEALIUM.cookie = {
		
	decodeBase64: function(str) {
		"use strict";

		var i, o1, o2, o3, h1, h2, h3, h4, bits, d=[], plain;
	    var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
	    for (i=0; i<str.length; i+=4) {
	        h1 = b64.indexOf(str.charAt(i));
	        h2 = b64.indexOf(str.charAt(i+1));
	        h3 = b64.indexOf(str.charAt(i+2));
	        h4 = b64.indexOf(str.charAt(i+3));
	
	        bits = h1<<18 | h2<<12 | h3<<6 | h4;
	
	        o1 = bits>>>16 & 0xff;
	        o2 = bits>>>8 & 0xff;
	        o3 = bits & 0xff;
	
	        d[i/4] = String.fromCharCode(o1, o2, o3);
	        if (h4 === 0x40) {
	        	d[i/4] = String.fromCharCode(o1, o2);
	        }
	        if (h3 === 0x40) {
	        	d[i/4] = String.fromCharCode(o1);
	        }
	    }
	    plain = d.join('');
	    
	    return plain;
	},

	calculateDomain: function(domainName) {
		"use strict";

	    var regex = new RegExp('.*(\\.[^.]*\\.[^.]*)$');
	    var groups = regex.exec(domainName);
	    if (groups && groups[1]) {
	        return groups[1];
	    } 
	    
	    return '';
	},
	
	copyProperties: function(source, target) {
		"use strict";

		var attr;
		
	    for (attr in source) {
	        if (source.hasOwnProperty(attr)) {
	            target[attr] = source[attr];
	        }
	    }
	    
	    return target;
	},
	
	readCookie: function(cookieName){
		"use strict";

	    var f, i, d = [],
	    	splittedCookie = document.cookie.split(";");
	    
	    cookieName = new RegExp("^\\s*" + cookieName + "=\\s*(.*?)\\s*$");
	    for(i=0; i<splittedCookie.length; i++){
	        f = splittedCookie[i].match(cookieName);
	        if(f) {
	        	d.push(f[1]);
	        }
	    }
	    
	    return d[0];
	},
	
	createOrOverwriteCookie: function(cookieName, value, expires, path, domain) {
		"use strict";

	    var cookie = cookieName + "=" + escape(value) + ";";
	
	    if (expires) {
	        // If it's a date
	        if (expires instanceof Date) {
	            // If it isn't a valid date
	            if (isNaN(expires.getTime())) {
	                expires = new Date();
	            }
	        } else {
	            expires = new Date(new Date().getTime() + parseInt(expires, 10) * 1000 * 60 * 60 * 24);
	    	}
	
	        cookie += "expires=" + expires.toGMTString() + ";";
	    }
	
	    if (path) {
	        cookie += "path=" + path + ";";
	    }
	    if (domain) {
	        cookie += "domain=" + domain + ";";
	    }
	
	    document.cookie = cookie;
	},

	deleteCookie: function(cookieName, path, domain) {
		"use strict";

	    // If the cookie exists
		var tealium = IS24.TEALIUM.cookie;

	    if (tealium.readCookie(cookieName)) {
	    	tealium.createOrOverwriteCookie(cookieName, "", -1, path, domain);
	    }
	},
	
	getCookieAsJson: function(cookieName) {
		"use strict";

	    var rawCookie = IS24.TEALIUM.cookie.readCookie(cookieName);
	    if (!rawCookie) {
	        return {};
	    }
	    
	    if (rawCookie.substring(0, 1) === '"') {
	        rawCookie = rawCookie.substring(1, rawCookie.length - 1);
	    }
	    
	    var value = IS24.TEALIUM.cookie.decodeBase64(rawCookie);
	    try {
	        return JSON.parse(value);
	    } catch (e) {
	        return {};
	    }
	},

	addLoadEvent: function(func) {
		"use strict";

	    var oldonload = window.onload;
	    if (typeof window.onload !== 'function') {
	        window.onload = func;
	    } else {
	        window.onload = function () {
	            if (oldonload) {
	                oldonload();
	            }
	            func();
	        };
	    }
	}
};

IS24.TEALIUM.cookie.addLoadEvent(function () {
	"use strict";

	var tealium = IS24.TEALIUM.cookie;
    
	var eveD = tealium.getCookieAsJson('eveD');
    window.utag_data = tealium.copyProperties(eveD, utag_data);
    
    var domain = tealium.calculateDomain(document.domain);
    tealium.deleteCookie('eveD', '/', domain);
});

(function(a,b,c,d){a='//tags-eu.tiqcdn.com/utag/immobilienscout/is24/prod/utag.js';b=document;c='script';d=b.createElement(c);d.src=a;d.type='text/java'+c;d.async=true;a=b.getElementsByTagName(c)[0];a.parentNode.insertBefore(d,a);})();/*global tealium */
/*jslint browser: true, sloppy: true, white: true, plusplus: true, evil: true */

var IS24 = IS24 || {};
IS24.isIE = /*@cc_on!@*/0;
IS24.registerNS = function (ns) {
    var i,
        nsParts = ns.split("."),
        root = window;
    for (i = 0; i < nsParts.length; i++) {
        if (root[nsParts[i]] === undefined) {
            root[nsParts[i]] = {};
        }
        root = root[nsParts[i]];
    }
};

IS24.registerNS("IS24.TEALIUM.tracking");

IS24.TEALIUM.tracking = {
    attachCommonUtagData: function (source) {
        var target = {
            svc_module_name: utag_data.svc_module_name,
            psn_iphash: utag_data.psn_iphash,
            svc_tm_version: utag_data.svc_tm_version,
            psn_usr_ssoid: utag_data.psn_usr_ssoid,
            pag_pagetitle: utag_data.pag_pagetitle
        };
        for (var attr in source) {
            if (source.hasOwnProperty(attr)) {
                target[attr] = source[attr];
            }
        }
        return target;
    },
    
    report: function (reportData) {
        if (window.utag) {
            var data = IS24.TEALIUM.tracking.attachCommonUtagData(reportData);
            utag.link(data);
        }
    }
};

function report(reportData) {
    IS24.TEALIUM.tracking.report(reportData);
}

