import{defineDisplay as e}from"@directus/extensions-sdk";import{defineComponent as t,openBlock as i,createElementBlock as o,toDisplayString as s}from"vue";var n=t({props:{value:{type:String,default:null}}});n.render=function(e,t,n,r,u,l){return i(),o("div",null,"Value: "+s(e.value),1)},n.__file="src/display.vue";var r=e({id:"custom",name:"Custom",icon:"box",description:"This is my custom display!",component:n,options:null,types:["string"]});export{r as default};
