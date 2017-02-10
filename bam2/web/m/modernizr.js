/*! modernizr 3.3.1 (Custom Build) | MIT *
 * https://modernizr.com/download/?-csscolumns-websockets-websocketsbinary-setclasses !*/
!function(e,n,t){function r(e,n){return typeof e===n}function o(){var e,n,t,o,s,i,a;for(var l in C)if(C.hasOwnProperty(l)){if(e=[],n=C[l],n.name&&(e.push(n.name.toLowerCase()),n.options&&n.options.aliases&&n.options.aliases.length))for(t=0;t<n.options.aliases.length;t++)e.push(n.options.aliases[t].toLowerCase());for(o=r(n.fn,"function")?n.fn():n.fn,s=0;s<e.length;s++)i=e[s],a=i.split("."),1===a.length?Modernizr[a[0]]=o:(!Modernizr[a[0]]||Modernizr[a[0]]instanceof Boolean||(Modernizr[a[0]]=new Boolean(Modernizr[a[0]])),Modernizr[a[0]][a[1]]=o),g.push((o?"":"no-")+a.join("-"))}}function s(e){var n=k.className,t=Modernizr._config.classPrefix||"";if(_&&(n=n.baseVal),Modernizr._config.enableJSClass){var r=new RegExp("(^|\\s)"+t+"no-js(\\s|$)");n=n.replace(r,"$1"+t+"js$2")}Modernizr._config.enableClasses&&(n+=" "+t+e.join(" "+t),_?k.className.baseVal=n:k.className=n)}function i(e,n){return!!~(""+e).indexOf(n)}function a(){return"function"!=typeof n.createElement?n.createElement(arguments[0]):_?n.createElementNS.call(n,"http://www.w3.org/2000/svg",arguments[0]):n.createElement.apply(n,arguments)}function l(e,n){return function(){return e.apply(n,arguments)}}function f(e,n,t){var o;for(var s in e)if(e[s]in n)return t===!1?e[s]:(o=n[e[s]],r(o,"function")?l(o,t||n):o);return!1}function u(e){return e.replace(/([a-z])-([a-z])/g,function(e,n,t){return n+t.toUpperCase()}).replace(/^-/,"")}function c(e){return e.replace(/([A-Z])/g,function(e,n){return"-"+n.toLowerCase()}).replace(/^ms-/,"-ms-")}function d(){var e=n.body;return e||(e=a(_?"svg":"body"),e.fake=!0),e}function p(e,t,r,o){var s,i,l,f,u="modernizr",c=a("div"),p=d();if(parseInt(r,10))for(;r--;)l=a("div"),l.id=o?o[r]:u+(r+1),c.appendChild(l);return s=a("style"),s.type="text/css",s.id="s"+u,(p.fake?p:c).appendChild(s),p.appendChild(c),s.styleSheet?s.styleSheet.cssText=e:s.appendChild(n.createTextNode(e)),c.id=u,p.fake&&(p.style.background="",p.style.overflow="hidden",f=k.style.overflow,k.style.overflow="hidden",k.appendChild(p)),i=t(c,e),p.fake?(p.parentNode.removeChild(p),k.style.overflow=f,k.offsetHeight):c.parentNode.removeChild(c),!!i}function m(n,r){var o=n.length;if("CSS"in e&&"supports"in e.CSS){for(;o--;)if(e.CSS.supports(c(n[o]),r))return!0;return!1}if("CSSSupportsRule"in e){for(var s=[];o--;)s.push("("+c(n[o])+":"+r+")");return s=s.join(" or "),p("@supports ("+s+") { #modernizr { position: absolute; } }",function(e){return"absolute"==getComputedStyle(e,null).position})}return t}function y(e,n,o,s){function l(){c&&(delete P.style,delete P.modElem)}if(s=r(s,"undefined")?!1:s,!r(o,"undefined")){var f=m(e,o);if(!r(f,"undefined"))return f}for(var c,d,p,y,h,v=["modernizr","tspan","samp"];!P.style&&v.length;)c=!0,P.modElem=a(v.shift()),P.style=P.modElem.style;for(p=e.length,d=0;p>d;d++)if(y=e[d],h=P.style[y],i(y,"-")&&(y=u(y)),P.style[y]!==t){if(s||r(o,"undefined"))return l(),"pfx"==n?y:!0;try{P.style[y]=o}catch(g){}if(P.style[y]!=h)return l(),"pfx"==n?y:!0}return l(),!1}function h(e,n,t,o,s){var i=e.charAt(0).toUpperCase()+e.slice(1),a=(e+" "+T.join(i+" ")+i).split(" ");return r(n,"string")||r(n,"undefined")?y(a,n,o,s):(a=(e+" "+E.join(i+" ")+i).split(" "),f(a,n,t))}function v(e,n,r){return h(e,t,t,n,r)}var g=[],C=[],b={_version:"3.3.1",_config:{classPrefix:"",enableClasses:!0,enableJSClass:!0,usePrefixes:!0},_q:[],on:function(e,n){var t=this;setTimeout(function(){n(t[e])},0)},addTest:function(e,n,t){C.push({name:e,fn:n,options:t})},addAsyncTest:function(e){C.push({name:null,fn:e})}},Modernizr=function(){};Modernizr.prototype=b,Modernizr=new Modernizr;var w=!1;try{w="WebSocket"in e&&2===e.WebSocket.CLOSING}catch(S){}Modernizr.addTest("websockets",w),Modernizr.addTest("websocketsbinary",function(){var n,t="https:"==location.protocol?"wss":"ws";if("WebSocket"in e){if(n="binaryType"in WebSocket.prototype)return n;try{return!!new WebSocket(t+"://.").binaryType}catch(r){}}return!1});var k=n.documentElement,_="svg"===k.nodeName.toLowerCase(),x="Moz O ms Webkit",T=b._config.usePrefixes?x.split(" "):[];b._cssomPrefixes=T;var E=b._config.usePrefixes?x.toLowerCase().split(" "):[];b._domPrefixes=E;var N={elem:a("modernizr")};Modernizr._q.push(function(){delete N.elem});var P={style:N.elem.style};Modernizr._q.unshift(function(){delete P.style}),b.testAllProps=h,b.testAllProps=v,function(){Modernizr.addTest("csscolumns",function(){var e=!1,n=v("columnCount");try{(e=!!n)&&(e=new Boolean(e))}catch(t){}return e});for(var e,n,t=["Width","Span","Fill","Gap","Rule","RuleColor","RuleStyle","RuleWidth","BreakBefore","BreakAfter","BreakInside"],r=0;r<t.length;r++)e=t[r].toLowerCase(),n=v("column"+t[r]),("breakbefore"===e||"breakafter"===e||"breakinside"==e)&&(n=n||v(t[r])),Modernizr.addTest("csscolumns."+e,n)}(),o(),s(g),delete b.addTest,delete b.addAsyncTest;for(var z=0;z<Modernizr._q.length;z++)Modernizr._q[z]();e.Modernizr=Modernizr}(window,document);