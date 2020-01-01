(this["webpackJsonpprob-stats-app"]=this["webpackJsonpprob-stats-app"]||[]).push([[0],{22:function(e,t,a){e.exports=a(32)},27:function(e,t,a){},28:function(e,t,a){},32:function(e,t,a){"use strict";a.r(t);var n=a(1),r=a.n(n),i=a(11),o=a.n(i),l=(a(27),a(28),a(15)),c=a(4),s=a(5),u=a(6),m=a(7),p=a(8),b=a(17),d=a(34),h=a(35),f=[{value:"<=",label:"<="},{value:"=",label:"="}];var v=function(e){if(e=parseInt(e,10),isNaN(e))return 1;if(e<=0)return 1;if(e>170)return 1/0;for(var t=1,a=e;a>0;a--)t*=a;return t};var g=[{value:"binomial",label:"binomial",func:function(e){var t=e.n,a=e.p;return{prob:function(e){return function(e,t){return e=parseInt(e,10),isNaN(e)&&(e=0),e<0&&(e=0),t=parseInt(t,10),isNaN(t)&&(t=0),t<0&&(t=0),t>e&&(t=e),v(e)/(v(t)*v(e-t))}(t,e)*Math.pow(a,e)*Math.pow(1-a,t-e)},mean:a,var:(1-a)*a,discrete:!0}},discrete:!0,params:{n:0,p:0}},{value:"geometric",label:"geometric",func:function(e){var t=e.p;return{prob:function(e){return Math.pow(1-t,e-1)*t},mean:1/t,var:(1-t)/(t*t),discrete:!0}},discrete:!0,params:{p:0}},{value:"uniform-continuous",label:"uniform continuous",discrete:!0,func:function(e){var t=e.b,a=e.a;return{prob:function(e){return 1/(t-a)},mean:(a+t)/2,var:(t-a)*(t-a)/12,discrete:!0}},params:{b:0,a:0}},{value:"poission",label:"poission",discrete:!0,func:function(e){var t=e.lambda;return{prob:function(e){return Math.pow(t,e)*Math.exp(-t)/v(e)},mean:t,var:t}},params:{lambda:0}}],E=function(e){return r.a.createElement("span",null,r.a.createElement("label",null,e.keyName),r.a.createElement("input",{id:e.keyName,className:"form-control",type:"number",value:e.param,onChange:e.onChange}))},y=function(e){function t(e){var a;return Object(c.a)(this,t),(a=Object(u.a)(this,Object(m.a)(t).call(this,e))).calculateProbability=function(){var e=0,t=a.state.distribution.func(a.state.params);if(a.state.distribution.discrete){if("<="===a.state.operation.value)for(var n=0;n<=a.state.upper;n++){e+=t.prob(n)}else for(var r=0;r<a.state.upper;r++)e+=t.prob(r);a.setState({output:e})}a.setState({mean:t.mean,variance:t.var})},a.handleLower=function(e){a.setState({lower:e.target.value},(function(){a.calculateProbability()}))},a.handleUpper=function(e){a.setState({upper:e.target.value},(function(){a.calculateProbability()}))},a.handleOperation=function(e){a.setState({operation:e},(function(){a.calculateProbability()}))},a.handleRandomVar=function(e){a.setState({randomVariable:e.target.value})},a.handleDistribution=function(e){a.setState({distribution:e,params:Object(l.a)({},e.params)},(function(){a.calculateProbability()}))},a.applyDistFunction=function(){var e=Object(l.a)({},a.state.distribution),t=a.state;t.mean=e.func(a.state.params).mean,t.variance=e.func(a.state.params).variance,a.setState(t)},a.handleParamsChange=function(e){var t=e.target.id,n=Object(l.a)({},a.state.params);n[t]=e.target.value,a.setState({params:n},(function(){a.applyDistFunction(),a.calculateProbability()}))},a.state={randomVariable:"X",lower:0,upper:8,operation:f[0],distribution:g[0],mean:0,variance:0,output:0,params:{}},a}return Object(p.a)(t,e),Object(s.a)(t,[{key:"componentDidMount",value:function(){this.handleDistribution(this.state.distribution)}},{key:"render",value:function(){var e=this;return r.a.createElement("div",null,r.a.createElement("h2",null,"Calculate Probability"),r.a.createElement(d.a,null,r.a.createElement(h.a,{xs:"2"},r.a.createElement("label",{htmlFor:"rand-var"},"Random Variable:")," ",r.a.createElement("input",{className:"form-control",id:"rand-var",type:"text",value:this.state.randomVariable,onChange:this.handleRandomVar})),r.a.createElement(h.a,{xs:"4"},r.a.createElement("label",{htmlFor:"select-op"},"Select Value: "),r.a.createElement(b.a,{id:"select-op",value:this.state.operation,onChange:this.handleOperation,options:f})),r.a.createElement(h.a,{xs:"4"},r.a.createElement("label",{htmlFor:"select-dist"},"Select Distribution: "),r.a.createElement(b.a,{id:"select-dist",value:this.state.distribution,onChange:this.handleDistribution,options:g})),r.a.createElement(h.a,{xs:"2"},r.a.createElement("label",{htmlFor:"upper-bound-value"},"Upper value:")," ",r.a.createElement("input",{className:"form-control",id:"upper-bound-value",type:"number",value:this.state.upper,onChange:this.handleUpper}))),r.a.createElement("div",{style:{display:"flex",backgroundColor:"lightgreen",margin:"2rem",padding:"1rem",textAlign:"center",justifyContent:"center"}},r.a.createElement(h.a,{xs:2},Object.keys(this.state.params).map((function(t){return r.a.createElement("div",{key:t},r.a.createElement(E,{keyName:t,param:e.state.params[t],onChange:e.handleParamsChange}))}))),r.a.createElement(h.a,null,"".concat(this.state.randomVariable," ~ ").concat(this.state.distribution.value,"(").concat(C(this.state.params),")"))),r.a.createElement(d.a,{style:{display:"flex",backgroundColor:"lightblue",margin:"2rem",padding:"1rem",textAlign:"center",justifyContent:"center"}},r.a.createElement(d.a,null,"P(".concat(this.state.randomVariable," ").concat(this.state.operation.value?this.state.operation.value:"Operation?"," ").concat(this.state.upper,") = ").concat(this.state.output))),r.a.createElement(d.a,{style:{backgroundColor:"orange",margin:"2rem",padding:"2rem",textAlign:"center",color:"black",justifyContent:"center"}},r.a.createElement(h.a,null,"Mean = ".concat(this.state.mean)),r.a.createElement(h.a,null,"Var(".concat(this.state.randomVariable,") = ").concat(this.state.variance)),r.a.createElement(h.a,null,"Sd(".concat(this.state.randomVariable,") = ").concat(Math.sqrt(this.state.variance)))))}}]),t}(r.a.Component),C=function(e){return Object.keys(e).map((function(t){return"".concat(t,"=").concat(e[t])}))},k=(a(31),a(21));var w=function(){return r.a.createElement("div",{className:"App"},r.a.createElement(k.a,null,r.a.createElement(y,null)))};Boolean("localhost"===window.location.hostname||"[::1]"===window.location.hostname||window.location.hostname.match(/^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/));o.a.render(r.a.createElement(w,null),document.getElementById("root")),"serviceWorker"in navigator&&navigator.serviceWorker.ready.then((function(e){e.unregister()}))}},[[22,1,2]]]);
//# sourceMappingURL=main.6e41443d.chunk.js.map