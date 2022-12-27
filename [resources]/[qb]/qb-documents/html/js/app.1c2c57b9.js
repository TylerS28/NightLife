(function(){"use strict";var e={4920:function(e,t,n){var a=n(9242),s=n(3396);function i(e,t,n,a,i,l){const o=(0,s.up)("router-view");return i.openned?((0,s.wg)(),(0,s.j4)(o,{key:0})):(0,s.kq)("",!0)}var l=n(6265),o=n.n(l),r={data(){return{openned:!1}},methods:{SendToClient:function(e,t){o().post(`https://${this.$store.state.name_resource}/${e}`,t).catch((t=>console.log(`An error has occurred (Main): ${e} : ${t}`)))},ReceiveLua:function(e){if(!e||!e.data)return;const t=e.data;t.config?(this.$store.state.translate=t.translate,this.$store.state.name_resource=t.name_resource,this.$store.state.server_banner=t.server_banner,this.SendToClient("ConfirmConfig",{})):t.open?this.openned=!0:t.see_document&&(this.$store.commit("SetDocuments",[t.document]),this.$router.push({name:"editor",params:{id:t.document.id,type:"document",action:"edit"}}))},Close:function(){this.SendToClient("Close",{}),this.openned=!1},KeyPress:function(e){const t=e.key;"Escape"==t&&this.Close()}},created:function(){window.addEventListener("message",this.ReceiveLua),window.addEventListener("keydown",this.KeyPress)},unmounted:function(){window.removeEventListener("message",this.ReceiveLua),window.removeEventListener("keydown",this.KeyPress)}},d=n(89);const c=(0,d.Z)(r,[["render",i]]);var _=c,u=n(678),m=n(7139);const T={class:"Dashboard"},p={class:"box"},g={class:"welcome"},h={class:"banner"},E=["src"];function f(e,t,n,a,i,l){const o=(0,s.up)("router-view");return(0,s.wg)(),(0,s.iD)("div",T,[(0,s._)("div",p,[(0,s._)("header",null,[(0,s._)("p",null,(0,m.zw)(i.translate.TR_DOCUMENT_SYSTEM),1)]),(0,s._)("main",null,[(0,s._)("section",g,[(0,s._)("div",h,[(0,s._)("img",{src:i.server_banner,alt:""},null,8,E)]),(0,s._)("h2",null,(0,m.zw)(i.translate.TR_WELCOME),1),(0,s._)("p",null,(0,m.zw)(i.translate.TR_WELCOME_TEXT),1)]),(0,s.Wm)(o)])])])}var v={data(){return{server_banner:"img/banner.png",translate:{}}},created:function(){this.server_banner=this.$store.state.server_banner,this.translate=this.$store.state.translate}};const w=(0,d.Z)(v,[["render",f],["__scopeId","data-v-e9b76c46"]]);var R=w;const D={class:"Document"},S={class:"mmodal"},C={class:"mbanner"},y=["src"],b={class:"mlink"},L=["placeholder"],k={class:"mlist"},I=["src","onClick"],A={key:0,class:"mmodal"},z={class:"mbanner"},O=["src"],M={class:"msave"},N=["placeholder"],x={key:1,class:"mmodal"},$={key:1},P=(0,s._)("p",{class:"errorX"},"X",-1),U={class:"errorText"},B={class:"msave"},H={class:"control"},V={key:0},G={key:1},W={key:0},Y=(0,s._)("i",{class:"fas fa-angle-right"},null,-1),F={key:1},X=(0,s._)("i",{class:"fas fa-angle-right"},null,-1),j=(0,s._)("i",{class:"fas fa-angle-right"},null,-1),q=(0,s._)("i",{class:"fas fa-angle-right"},null,-1),K=(0,s._)("i",{class:"fas fa-angle-right"},null,-1),Z=(0,s._)("i",{class:"fas fa-angle-right"},null,-1),J={class:"pages"},Q={class:"page"},ee=(0,s._)("img",{class:"triangulo",src:"img/canto.png",alt:""},null,-1),te={class:"banner"},ne=["src"],ae=["readonly"],se=["readonly"],ie={class:"text"},le=["readonly"],oe=["placeholder","readonly"],re=(0,s._)("img",{src:"img/rodape.png",alt:"",class:"rodape"},null,-1),de={class:"createInfo"},ce={key:0},_e={key:1},ue={key:2},me={key:0,class:"page"},Te=(0,s._)("img",{class:"triangulo",src:"img/canto.png",alt:""},null,-1),pe={class:"text"},ge={key:0,class:"delete"},he=["onClick"],Ee=["src"],fe={key:0},ve=(0,s._)("i",{class:"far fa-image"},null,-1),we={key:1,class:"new-image"},Re=["placeholder"],De=(0,s._)("img",{src:"img/rodape.png",alt:"",class:"rodape"},null,-1),Se={class:"createInfo"},Ce={key:0},ye={key:1},be={key:2},Le={class:"page"},ke=(0,s._)("img",{class:"triangulo",src:"img/canto.png",alt:""},null,-1),Ie={class:"text"},Ae=["placeholder","onUpdate:modelValue","readonly"],ze=["placeholder","onUpdate:modelValue","readonly"],Oe=(0,s._)("img",{src:"img/rodape.png",alt:"",class:"rodape"},null,-1),Me={class:"createInfo"},Ne={key:0},xe={key:1},$e={key:2};function Pe(e,t,n,i,l,o){const r=(0,s.up)("Modal"),d=(0,s.up)("Loading");return(0,s.wg)(),(0,s.iD)("div",D,[l.modal_banner?((0,s.wg)(),(0,s.j4)(r,{key:0,title:l.translate.TR_CHOOSE_PHOTO},{default:(0,s.w5)((()=>[(0,s._)("div",S,[(0,s._)("div",C,[l.new_banner?((0,s.wg)(),(0,s.iD)("img",{key:0,src:l.new_banner},null,8,y)):(0,s.kq)("",!0)]),(0,s._)("div",b,[(0,s.wy)((0,s._)("input",{type:"text",placeholder:l.translate.TR_PLACE_URL,"onUpdate:modelValue":t[0]||(t[0]=e=>l.url_new_banner=e)},null,8,L),[[a.nr,l.url_new_banner]]),(0,s._)("p",{onClick:t[1]||(t[1]=e=>o.LoadBanner(l.url_new_banner))},(0,m.zw)(l.translate.TR_LOAD),1),(0,s._)("p",{onClick:t[2]||(t[2]=(...e)=>o.ChangeBanner&&o.ChangeBanner(...e))},(0,m.zw)(l.translate.TR_CHANGE),1),(0,s._)("p",{onClick:t[3]||(t[3]=e=>o.SetModalBanner(!1))},(0,m.zw)(l.translate.TR_CANCEL),1)]),(0,s._)("div",k,[(0,s._)("p",null,(0,m.zw)(l.translate.TR_OR_PREVIEW)+":",1),(0,s._)("div",null,[((0,s.wg)(!0),(0,s.iD)(s.HY,null,(0,s.Ko)(l.list_banners,((e,t)=>((0,s.wg)(),(0,s.iD)("div",{class:"mbanner",key:`banners_${t}`},[(0,s._)("img",{src:e,onClick:t=>o.LoadBanner(e)},null,8,I)])))),128))])])])])),_:1},8,["title"])):(0,s.kq)("",!0),l.is_saving?((0,s.wg)(),(0,s.j4)(r,{key:1,title:l.translate.TR_SAVE_DOCUMENT},{default:(0,s.w5)((()=>[l.loading_save?((0,s.wg)(),(0,s.iD)("div",x,[l.save_error?((0,s.wg)(),(0,s.iD)("div",$,[P,(0,s._)("p",U,(0,m.zw)(l.save_error_msg),1),(0,s._)("div",B,[(0,s._)("div",null,[(0,s._)("p",{onClick:t[7]||(t[7]=(...e)=>o.CloseSave&&o.CloseSave(...e))},"Sair")])])])):((0,s.wg)(),(0,s.j4)(d,{key:0,text:l.translate.TR_SAVING},null,8,["text"]))])):((0,s.wg)(),(0,s.iD)("div",A,[(0,s._)("div",z,[(0,s._)("img",{src:l.banner},null,8,O)]),(0,s._)("div",M,[(0,s.wy)((0,s._)("input",{type:"text",placeholder:l.translate.TR_NAME_DOCUMENT,"onUpdate:modelValue":t[4]||(t[4]=e=>l.name_document=e)},null,8,N),[[a.nr,l.name_document]]),(0,s._)("div",null,[(0,s._)("p",{onClick:t[5]||(t[5]=(...e)=>o.SaveDocument&&o.SaveDocument(...e))},(0,m.zw)(l.translate.TR_CONFIRM),1),(0,s._)("p",{onClick:t[6]||(t[6]=e=>o.SetIsSaving(!1))},(0,m.zw)(l.translate.TR_CANCEL),1)])])]))])),_:1},8,["title"])):(0,s.kq)("",!0),(0,s._)("div",H,[(0,s._)("header",null,["template"==n.type?((0,s.wg)(),(0,s.iD)("h2",V,(0,m.zw)(l.translate.TR_TEMPLATE)+" "+(0,m.zw)(l.name_document),1)):(0,s.kq)("",!0),"document"==n.type?((0,s.wg)(),(0,s.iD)("h2",G,(0,m.zw)(l.translate.TR_DOCUMENT)+" "+(0,m.zw)(l.name_document),1)):(0,s.kq)("",!0)]),l.readonly?((0,s.wg)(),(0,s.iD)("section",W,[(0,s._)("div",{class:"option",onClick:t[8]||(t[8]=()=>e.$router.back())},[(0,s._)("p",null,(0,m.zw)(l.translate.TR_BACK),1),Y])])):((0,s.wg)(),(0,s.iD)("section",F,[(0,s._)("div",{class:"option",onClick:t[9]||(t[9]=e=>o.SetModalBanner(!0))},[(0,s._)("p",null,(0,m.zw)(l.translate.TR_CHANGE_BANNER),1),X]),(0,s._)("div",{class:"option",onClick:t[10]||(t[10]=(...e)=>o.AddSignature&&o.AddSignature(...e))},[(0,s._)("p",null,(0,m.zw)(l.translate.TR_ADD_SIG),1),j]),(0,s._)("div",{class:"option",onClick:t[11]||(t[11]=(...e)=>o.RemoveSignature&&o.RemoveSignature(...e))},[(0,s._)("p",null,(0,m.zw)(l.translate.TR_DEL_SIG),1),q]),(0,s._)("div",{class:"option",onClick:t[12]||(t[12]=e=>o.SetIsSaving(!0))},[(0,s._)("p",null,(0,m.zw)(l.translate.TR_SAVE),1),K]),(0,s._)("div",{class:"option",onClick:t[13]||(t[13]=()=>e.$router.back())},[(0,s._)("p",null,(0,m.zw)(l.translate.TR_BACK),1),Z])]))]),(0,s._)("div",J,[(0,s._)("section",Q,[ee,(0,s._)("header",null,[(0,s._)("div",te,[(0,s._)("img",{src:l.banner,alt:""},null,8,ne)]),(0,s.wy)((0,s._)("input",{class:"title",type:"text","onUpdate:modelValue":t[14]||(t[14]=e=>l.title=e),spellcheck:"false",readonly:l.readonly},null,8,ae),[[a.nr,l.title]]),(0,s.wy)((0,s._)("input",{class:"date",type:"text","onUpdate:modelValue":t[15]||(t[15]=e=>l.date=e),spellcheck:"false",readonly:l.readonly},null,8,se),[[a.nr,l.date]])]),(0,s._)("div",ie,[(0,s.wy)((0,s._)("input",{class:"subtitle","onUpdate:modelValue":t[16]||(t[16]=e=>l.subtitle=e),type:"text",readonly:l.readonly},null,8,le),[[a.nr,l.subtitle]]),(0,s.wy)((0,s._)("textarea",{ref:"text","onUpdate:modelValue":t[17]||(t[17]=e=>l.body=e),onInput:t[18]||(t[18]=(...e)=>o.AutoResize&&o.AutoResize(...e)),placeholder:l.translate.TR_TEXT_HERE,readonly:l.readonly},null,40,oe),[[a.nr,l.body]])]),re,(0,s._)("div",de,[l.created_by?((0,s.wg)(),(0,s.iD)("p",ce,(0,m.zw)(l.translate.TR_CREATED_BY)+" "+(0,m.zw)(l.created_by),1)):(0,s.kq)("",!0),l.updated_by?((0,s.wg)(),(0,s.iD)("p",_e,(0,m.zw)(l.translate.TR_UPDATED_BY)+" "+(0,m.zw)(l.updated_by),1)):(0,s.kq)("",!0),l.finish_by?((0,s.wg)(),(0,s.iD)("p",ue,(0,m.zw)(l.translate.TR_FINISH_BY)+" "+(0,m.zw)(l.finish_by),1)):(0,s.kq)("",!0)])]),!l.readonly||l.images.length>0?((0,s.wg)(),(0,s.iD)("section",me,[Te,(0,s._)("div",pe,[((0,s.wg)(!0),(0,s.iD)(s.HY,null,(0,s.Ko)(l.images,((e,t)=>((0,s.wg)(),(0,s.iD)("div",{class:"images",key:`image_${t}`},[l.readonly?(0,s.kq)("",!0):((0,s.wg)(),(0,s.iD)("div",ge,[(0,s._)("i",{class:"fas fa-eraser",onClick:e=>o.RemoveImage(t)},null,8,he),(0,s._)("p",null,(0,m.zw)(l.translate.TR_DELETE_IMG),1)])),(0,s._)("img",{src:e},null,8,Ee)])))),128)),l.readonly?(0,s.kq)("",!0):((0,s.wg)(),(0,s.iD)("div",fe,[l.is_inserting?((0,s.wg)(),(0,s.iD)("div",we,[(0,s._)("p",null,(0,m.zw)(l.translate.TR_TEXT_INSERT_IMG),1),(0,s.wy)((0,s._)("input",{type:"text",placeholder:l.translate.TR_PUT_URL,"onUpdate:modelValue":t[20]||(t[20]=e=>l.new_image=e)},null,8,Re),[[a.nr,l.new_image]]),(0,s._)("p",{class:"button",onClick:t[21]||(t[21]=(...e)=>o.InsertImage&&o.InsertImage(...e))},(0,m.zw)(l.translate.TR_INSERT),1)])):((0,s.wg)(),(0,s.iD)("div",{key:0,class:"insert",onClick:t[19]||(t[19]=e=>o.SetIsInserting(!0))},[ve,(0,s._)("p",null,(0,m.zw)(l.translate.TR_CLICK_IMG),1)]))]))]),De,(0,s._)("div",Se,[l.created_by?((0,s.wg)(),(0,s.iD)("p",Ce,(0,m.zw)(l.translate.TR_CREATED_BY)+" "+(0,m.zw)(l.created_by),1)):(0,s.kq)("",!0),l.updated_by?((0,s.wg)(),(0,s.iD)("p",ye,(0,m.zw)(l.translate.TR_UPDATED_BY)+" "+(0,m.zw)(l.updated_by),1)):(0,s.kq)("",!0),l.finish_by?((0,s.wg)(),(0,s.iD)("p",be,(0,m.zw)(l.translate.TR_FINISH_BY)+" "+(0,m.zw)(l.finish_by),1)):(0,s.kq)("",!0)])])):(0,s.kq)("",!0),(0,s._)("section",Le,[ke,(0,s._)("div",Ie,[((0,s.wg)(!0),(0,s.iD)(s.HY,null,(0,s.Ko)(l.signatures,((e,t)=>((0,s.wg)(),(0,s.iD)("div",{class:"assinatura",key:`signature_${t}`},[(0,s.wy)((0,s._)("input",{class:"name",type:"text",placeholder:l.translate.TR_EXAMPLE_NAME,"onUpdate:modelValue":e=>l.signatures[t].name=e,readonly:l.readonly},null,8,Ae),[[a.nr,l.signatures[t].name]]),(0,s.wy)((0,s._)("input",{class:"job",type:"text",placeholder:l.translate.TR_EXAMPLE_INFO,"onUpdate:modelValue":e=>l.signatures[t].info=e,readonly:l.readonly},null,8,ze),[[a.nr,l.signatures[t].info]])])))),128))]),Oe,(0,s._)("div",Me,[l.created_by?((0,s.wg)(),(0,s.iD)("p",Ne,(0,m.zw)(l.translate.TR_CREATED_BY)+" "+(0,m.zw)(l.created_by),1)):(0,s.kq)("",!0),l.updated_by?((0,s.wg)(),(0,s.iD)("p",xe,(0,m.zw)(l.translate.TR_UPDATED_BY)+" "+(0,m.zw)(l.updated_by),1)):(0,s.kq)("",!0),l.finish_by?((0,s.wg)(),(0,s.iD)("p",$e,(0,m.zw)(l.translate.TR_FINISH_BY)+" "+(0,m.zw)(l.finish_by),1)):(0,s.kq)("",!0)])])])])}n(6699);const Ue={class:"modal"},Be={class:"header"},He={class:"slot"};function Ve(e,t,n,a,i,l){return(0,s.wg)(),(0,s.iD)("div",Ue,[(0,s._)("div",Be,[(0,s._)("p",null,(0,m.zw)(n.title),1)]),(0,s._)("div",He,[(0,s.WI)(e.$slots,"default",{},void 0,!0)])])}var Ge={name:"ModalVue",props:{title:{type:String,default:""}}};const We=(0,d.Z)(Ge,[["render",Ve],["__scopeId","data-v-5b2f1196"]]);var Ye=We;const Fe={class:"loading"};function Xe(e,t,n,a,i,l){return(0,s.wg)(),(0,s.iD)("div",Fe,[(0,s._)("div",{class:"loader",style:(0,m.j5)({width:n.size,height:n.size,borderColor:n.color.secondary,borderTopColor:n.color.primary})},null,4),(0,s._)("p",{style:(0,m.j5)({color:n.colorText,fontSize:n.textSize})},(0,m.zw)(n.text),5)])}var je={name:"LoadingVue",props:{color:{default:{primary:"var(--theme-color)",secondary:"#f3f3f3"}},size:{default:"12vh"},text:{default:""},colorText:{default:"black"},textSize:{default:"1.7vh"}}};const qe=(0,d.Z)(je,[["render",Xe],["__scopeId","data-v-366b93c8"]]);var Ke=qe,Ze={components:{Modal:Ye,Loading:Ke},props:{type:{},action:{},id:{}},data(){return{is_inserting:!1,name_document:"",title:"Document Title",date:"April 16, 2020",subtitle:"YOUR TITLE",body:"",images:[],signatures:[{name:"",info:""}],created_by:"",updated_by:"",finish_by:"",new_image:"",modal_banner:!1,banner:this.$store.state.server_banner,url_new_banner:"",new_banner:"",list_banners:[],is_saving:!1,loading_save:!1,save_error:!1,save_error_msg:"",readonly:!1,translate:{}}},methods:{AutoResize:function(){const e=this.$refs.text;e&&(e.style.height="2.2vh",e.style.height=e.scrollHeight+"px")},SetIsInserting:function(e){this.is_inserting=e},SetModalBanner:function(e){this.modal_banner=e},SetIsSaving:function(e){this.is_saving=e},SetLoadingSave:function(e){this.loading_save=e},CloseSave:function(){this.SetIsSaving(!1),this.SetLoadingSave(!1)},InsertImage:function(){this.images.push(this.new_image)},RemoveImage:function(e){this.images.splice(e,1)},AddSignature:function(){this.signatures.push({name:"",info:""})},RemoveSignature:function(){this.signatures.length>0&&this.signatures.pop()},LoadBanner:function(e){this.new_banner=e},ChangeBanner:function(){this.new_banner&&(this.banner=this.new_banner,this.list_banners.includes(this.new_banner)||(this.list_banners=[this.new_banner,...this.list_banners],localStorage.list_banners=JSON.stringify(this.list_banners)),this.SetModalBanner(!1))},SaveDocument:function(){if(!this.name_document)return;this.SetLoadingSave(!0);let e=null,t="template"==this.type?1:0;"edit"==this.action&&(e=this.id),this.SendToClient("SaveDocument",{document:{name_document:this.name_document,title:this.title,date:this.date,subtitle:this.subtitle,body:this.body,images:this.images,signatures:this.signatures,banner:this.banner,type:t},document_id:e})},InitializeDocument:function(){if(this.translate=this.$store.state.translate,-1!=this.id){let e=null;"create"==this.action?e=this.$store.getters.GetTemplate(this.id):(e="template"==this.type?this.$store.getters.GetTemplate(this.id):this.$store.getters.GetDocument(this.id),this.name_document=e.infos.name_document,this.readonly=0==e.infos.status),this.banner=e.infos.banner,this.title=e.infos.title,this.date=e.infos.date,this.subtitle=e.infos.subtitle,this.body=e.body,this.images=e.images,this.signatures=e.signatures,this.created_by=e.infos.created_by,this.updated_by=e.infos.updated_by,this.finish_by=e.infos.finish_by}else this.title=this.translate.TR_TITLE,this.date=this.translate.TR_DATE,this.subtitle=this.translate.TR_SUBTITLE},SendToClient:function(e,t){o().post(`https://${this.$store.state.name_resource}/${e}`,t).catch((t=>console.log(`An error has occurred (DocumentView): ${e} : ${t}`)))},ReceiveLua:function(e){if(!e||!e.data)return;const t=e.data;t.confirm_action?"template"==this.type?this.$router.back():this.$router.go(-2):t.cancel_action&&(this.save_error=!0,this.save_error_msg=t.cancel_msg)}},mounted:function(){this.AutoResize()},created:function(){localStorage.list_banners&&(this.list_banners=JSON.parse(localStorage.list_banners)),this.InitializeDocument(),window.addEventListener("message",this.ReceiveLua)},unmounted:function(){window.removeEventListener("message",this.ReceiveLua)}};const Je=(0,d.Z)(Ze,[["render",Pe]]);var Qe=Je;const et=e=>((0,s.dD)("data-v-aadb32a8"),e=e(),(0,s.Cn)(),e),tt={class:"documents"},nt={class:"buttons"},at={class:"options"},st={key:0},it={class:"search"},lt=et((()=>(0,s._)("i",{class:"fas fa-search"},null,-1))),ot=["placeholder"],rt={class:"list-documents"},dt={class:"item-data"},ct=["src"],_t={class:"item-info"},ut={class:"item-title"},mt={class:"item-status"},Tt={key:1,class:"loading"},pt={key:2,class:"loading"};function gt(e,t,n,i,l,o){const r=(0,s.up)("router-link"),d=(0,s.up)("VueCustomTooltip"),c=(0,s.up)("Loading");return(0,s.wg)(),(0,s.iD)("section",tt,[(0,s._)("div",nt,[(0,s.Wm)(d,{label:l.translate.TR_CREATE_M_LABEL},{default:(0,s.w5)((()=>[(0,s.Wm)(r,{to:"/home/templates"},{default:(0,s.w5)((()=>[(0,s.Uk)((0,m.zw)(l.translate.TR_NEW_DOCUMENT),1)])),_:1})])),_:1},8,["label"])]),(0,s._)("div",at,[(0,s._)("p",null,(0,m.zw)(l.translate.TR_MY_DOCUMENTS),1)]),!l.is_loading&&l.documents.length>0?((0,s.wg)(),(0,s.iD)("div",st,[(0,s._)("div",it,[lt,(0,s.wy)((0,s._)("input",{type:"text",placeholder:l.translate.TR_SEARCH,"onUpdate:modelValue":t[0]||(t[0]=e=>l.search=e)},null,8,ot),[[a.nr,l.search]])]),(0,s._)("div",rt,[((0,s.wg)(!0),(0,s.iD)(s.HY,null,(0,s.Ko)(l.documents.filter((e=>e.infos.name_document.toLowerCase().includes(l.search.toLowerCase()))),((e,t)=>((0,s.wg)(),(0,s.j4)(r,{class:"item-doc",key:`document_${t}`,to:{name:"options",params:{id:e.id}}},{default:(0,s.w5)((()=>[(0,s._)("p",dt,(0,m.zw)(e.infos.name_document),1),(0,s._)("img",{src:e.infos.banner,alt:""},null,8,ct),(0,s._)("div",_t,[(0,s._)("p",ut,(0,m.zw)(e.infos.title),1),(0,s._)("p",mt,(0,m.zw)(1==e.infos.status?l.translate.TR_OPENNED:l.translate.TR_CLOSED),1)])])),_:2},1032,["to"])))),128))])])):l.is_loading?((0,s.wg)(),(0,s.iD)("div",pt,[(0,s.Wm)(c,{text:l.translate.TR_LOADING_DOCS,size:"9vh",textSize:"1.7vh"},null,8,["text"])])):((0,s.wg)(),(0,s.iD)("div",Tt,[(0,s._)("p",null,(0,m.zw)(l.translate.TR_EMPTY_DOCS),1)]))])}var ht={components:{Loading:Ke},data(){return{search:"",documents:[],is_loading:!1,translate:{}}},methods:{SendToClient:function(e,t){o().post(`https://${this.$store.state.name_resource}/${e}`,t).catch((t=>console.log(`An error has occurred (ListDocuments): ${e} : ${t}`)))},ReceiveLua:function(e){if(!e||!e.data)return;const t=e.data;t.load_documents&&(this.$store.commit("SetDocuments",t.documents),this.documents=t.documents,this.is_loading=!1)}},created:function(){window.addEventListener("message",this.ReceiveLua),this.translate=this.$store.state.translate,this.is_loading=!0,this.SendToClient("LoadDocuments",{})},unmounted:function(){window.removeEventListener("message",this.ReceiveLua)}};const Et=(0,d.Z)(ht,[["render",gt],["__scopeId","data-v-aadb32a8"]]);var ft=Et;const vt=e=>((0,s.dD)("data-v-3bb79f90"),e=e(),(0,s.Cn)(),e),wt={class:"documents"},Rt={key:0,class:"mmodal"},Dt={class:"mtext"},St={class:"mbuttons"},Ct={key:1,class:"mmodal"},yt={key:1},bt=vt((()=>(0,s._)("p",{class:"errorX"},"X",-1))),Lt={class:"errorText"},kt={class:"msave"},It={class:"buttons"},At={class:"options"},zt={key:1,class:"list-templates"},Ot=["src"],Mt={class:"temp-info"},Nt={class:"temp-options"},xt=vt((()=>(0,s._)("i",{class:"fas fa-edit"},null,-1))),$t=["onClick"],Pt=vt((()=>(0,s._)("i",{class:"fas fa-angle-right"},null,-1))),Ut={key:2,class:"loading"},Bt={key:3,class:"loading"};function Ht(e,t,n,a,i,l){const o=(0,s.up)("Loading"),r=(0,s.up)("Modal"),d=(0,s.up)("router-link"),c=(0,s.up)("VueCustomTooltip");return(0,s.wg)(),(0,s.iD)("section",wt,[i.is_deleting?((0,s.wg)(),(0,s.j4)(r,{key:0,title:i.translate.TR_DELETE_TITLE2},{default:(0,s.w5)((()=>[i.loading_delete?((0,s.wg)(),(0,s.iD)("div",Ct,[i.save_error?((0,s.wg)(),(0,s.iD)("div",yt,[bt,(0,s._)("p",Lt,(0,m.zw)(i.save_error_msg),1),(0,s._)("div",kt,[(0,s._)("div",null,[(0,s._)("p",{onClick:t[2]||(t[2]=(...e)=>l.CloseSave&&l.CloseSave(...e))},(0,m.zw)(i.translate.TR_EXIT),1)])])])):((0,s.wg)(),(0,s.j4)(o,{key:0,text:i.translate.TR_SAVING},null,8,["text"]))])):((0,s.wg)(),(0,s.iD)("div",Rt,[(0,s._)("p",Dt,(0,m.zw)(i.translate.TR_DELETE_TEXT2),1),(0,s._)("div",St,[(0,s._)("p",{onClick:t[0]||(t[0]=(...e)=>l.DeleteDocument&&l.DeleteDocument(...e))},(0,m.zw)(i.translate.TR_YES),1),(0,s._)("p",{onClick:t[1]||(t[1]=e=>l.SetIsDeleting(!1))},(0,m.zw)(i.translate.TR_NO),1)])]))])),_:1},8,["title"])):(0,s.kq)("",!0),(0,s._)("div",It,[(0,s.Wm)(c,{label:i.translate.TR_BACK_DOCUMENTS},{default:(0,s.w5)((()=>[(0,s.Wm)(d,{to:{name:"documents"}},{default:(0,s.w5)((()=>[(0,s.Uk)((0,m.zw)(i.translate.TR_BACK),1)])),_:1})])),_:1},8,["label"]),(0,s.Wm)(c,{label:i.translate.TR_CREATE_TEMPLATE},{default:(0,s.w5)((()=>[(0,s.Wm)(d,{to:{name:"editor",params:{id:-1,action:"create",type:"template"}}},{default:(0,s.w5)((()=>[(0,s.Uk)((0,m.zw)(i.translate.TR_NEW_TEMPLATE),1)])),_:1})])),_:1},8,["label"])]),(0,s._)("div",At,[(0,s._)("p",null,(0,m.zw)(i.translate.TR_CHOOSE_TEMPLATE),1)]),!i.is_loading&&i.templates.length>0?((0,s.wg)(),(0,s.iD)("div",zt,[((0,s.wg)(!0),(0,s.iD)(s.HY,null,(0,s.Ko)(i.templates,((e,t)=>((0,s.wg)(),(0,s.iD)("div",{class:"item-temp",key:`template_${t}`},[(0,s.Wm)(d,{to:{name:"editor",params:{id:e.id,action:"create",type:"document"}}},{default:(0,s.w5)((()=>[(0,s._)("img",{src:e.infos.banner,alt:""},null,8,Ot)])),_:2},1032,["to"]),(0,s._)("div",Mt,[(0,s.Wm)(c,{label:i.translate.TR_CHOOSE_TEMPLATE2},{default:(0,s.w5)((()=>[(0,s.Wm)(d,{to:{name:"editor",params:{id:e.id,action:"create",type:"document"}}},{default:(0,s.w5)((()=>[(0,s._)("p",null,(0,m.zw)(e.infos.name_document),1)])),_:2},1032,["to"])])),_:2},1032,["label"])]),(0,s._)("div",Nt,[(0,s.Wm)(c,{label:i.translate.TR_EDIT_TEMPLATE},{default:(0,s.w5)((()=>[(0,s.Wm)(d,{to:{name:"editor",params:{id:e.id,action:"edit",type:"template"}}},{default:(0,s.w5)((()=>[xt])),_:2},1032,["to"])])),_:2},1032,["label"]),(0,s.Wm)(c,{label:i.translate.TR_DELETE_TEMPLATE},{default:(0,s.w5)((()=>[(0,s._)("i",{class:"fas fa-trash",onClick:t=>l.SetDeleteId(e.id)},null,8,$t)])),_:2},1032,["label"]),(0,s.Wm)(d,{to:{name:"editor",params:{id:e.id,action:"create",type:"document"}}},{default:(0,s.w5)((()=>[Pt])),_:2},1032,["to"])])])))),128))])):i.is_loading?((0,s.wg)(),(0,s.iD)("div",Bt,[(0,s.Wm)(o,{text:i.translate.TR_LOADING_TEMPS,size:"9vh",textSize:"1.7vh"},null,8,["text"])])):((0,s.wg)(),(0,s.iD)("div",Ut,[(0,s._)("p",null,(0,m.zw)(i.translate.TR_EMPTY_TEMPS),1)]))])}var Vt={components:{Modal:Ye,Loading:Ke},data(){return{is_deleting:!1,templates:[],is_loading:!1,delete_id:-1,loading_delete:!1,save_error:!1,save_error_msg:"",translate:{}}},methods:{SetDeleteId:function(e){this.SetIsDeleting(!0),this.delete_id=e},SetIsDeleting:function(e){this.is_deleting=e},SetLoadingDelete:function(e){this.loading_delete=e},CloseSave:function(){this.SetIsDeleting(!1),this.SetLoadingDelete(!1)},DeleteDocument:function(){this.SendToClient("DeleteDocument",{document_id:this.delete_id}),this.SetLoadingDelete(!0)},LoadTemplates:function(){this.is_loading=!0,this.SendToClient("LoadTemplates",{})},SendToClient:function(e,t){o().post(`https://${this.$store.state.name_resource}/${e}`,t).catch((t=>console.log(`An error has occurred (ListTemplates): ${e} : ${t}`)))},ReceiveLua:function(e){if(!e||!e.data)return;const t=e.data;t.load_templates?(this.$store.commit("SetTemplates",t.templates),this.templates=t.templates,this.is_loading=!1):t.confirm_action?(this.LoadTemplates(),this.CloseSave()):t.cancel_action&&(this.save_error=!0,this.save_error_msg=t.cancel_msg)}},created:function(){window.addEventListener("message",this.ReceiveLua),this.translate=this.$store.state.translate,this.LoadTemplates()},unmounted:function(){window.removeEventListener("message",this.ReceiveLua)}};const Gt=(0,d.Z)(Vt,[["render",Ht],["__scopeId","data-v-3bb79f90"]]);var Wt=Gt;const Yt=e=>((0,s.dD)("data-v-b5a66028"),e=e(),(0,s.Cn)(),e),Ft={class:"documents"},Xt={key:0,class:"mmodal"},jt={class:"mtext"},qt={class:"mbuttons"},Kt={key:1,class:"mmodal"},Zt={key:1},Jt=Yt((()=>(0,s._)("p",{class:"errorX"},"X",-1))),Qt={class:"errorText"},en={class:"msave"},tn={key:0,class:"mmodal"},nn={class:"mtext"},an={class:"mbuttons"},sn={key:1,class:"mmodal"},ln={key:1},on=Yt((()=>(0,s._)("p",{class:"errorX"},"X",-1))),rn={class:"errorText"},dn={class:"msave"},cn={class:"buttons"},_n={class:"box"},un={class:"side header"},mn={class:"banner"},Tn=["src"],pn={class:"infos"},gn={class:"side right"},hn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-left"},null,-1))),En=Yt((()=>(0,s._)("i",{class:"fas fa-angle-right"},null,-1))),fn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-left"},null,-1))),vn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-right"},null,-1))),wn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-left"},null,-1))),Rn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-right"},null,-1))),Dn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-left"},null,-1))),Sn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-right"},null,-1))),Cn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-left"},null,-1))),yn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-right"},null,-1))),bn=Yt((()=>(0,s._)("i",{class:"fas fa-angle-left"},null,-1))),Ln=Yt((()=>(0,s._)("i",{class:"fas fa-angle-right"},null,-1)));function kn(e,t,n,a,i,l){const o=(0,s.up)("Loading"),r=(0,s.up)("Modal"),d=(0,s.up)("router-link"),c=(0,s.up)("VueCustomTooltip");return(0,s.wg)(),(0,s.iD)("section",Ft,[i.is_deleting?((0,s.wg)(),(0,s.j4)(r,{key:0,title:i.translate.TR_DELETE_TITLE},{default:(0,s.w5)((()=>[i.loading_delete?((0,s.wg)(),(0,s.iD)("div",Kt,[i.save_error?((0,s.wg)(),(0,s.iD)("div",Zt,[Jt,(0,s._)("p",Qt,(0,m.zw)(i.save_error_msg),1),(0,s._)("div",en,[(0,s._)("div",null,[(0,s._)("p",{onClick:t[2]||(t[2]=(...e)=>l.CloseSave&&l.CloseSave(...e))},(0,m.zw)(i.translate.TR_EXIT),1)])])])):((0,s.wg)(),(0,s.j4)(o,{key:0,text:i.translate.TR_SAVING},null,8,["text"]))])):((0,s.wg)(),(0,s.iD)("div",Xt,[(0,s._)("p",jt,(0,m.zw)(i.translate.TR_DELETE_TEXT),1),(0,s._)("div",qt,[(0,s._)("p",{onClick:t[0]||(t[0]=(...e)=>l.DeleteDocument&&l.DeleteDocument(...e))},(0,m.zw)(i.translate.TR_YES),1),(0,s._)("p",{onClick:t[1]||(t[1]=e=>l.SetIsDeleting(!1))},(0,m.zw)(i.translate.TR_NO),1)])]))])),_:1},8,["title"])):(0,s.kq)("",!0),i.is_finishing?((0,s.wg)(),(0,s.j4)(r,{key:1,title:i.translate.TR_FINISH_TITLE},{default:(0,s.w5)((()=>[i.loading_finish?((0,s.wg)(),(0,s.iD)("div",sn,[i.save_error?((0,s.wg)(),(0,s.iD)("div",ln,[on,(0,s._)("p",rn,(0,m.zw)(i.save_error_msg),1),(0,s._)("div",dn,[(0,s._)("div",null,[(0,s._)("p",{onClick:t[5]||(t[5]=(...e)=>l.CloseSave&&l.CloseSave(...e))},(0,m.zw)(i.translate.TR_EXIT),1)])])])):((0,s.wg)(),(0,s.j4)(o,{key:0,text:i.translate.TR_SAVING},null,8,["text"]))])):((0,s.wg)(),(0,s.iD)("div",tn,[(0,s._)("p",nn,(0,m.zw)(i.translate.TR_FINISH_TEXT),1),(0,s._)("div",an,[(0,s._)("p",{onClick:t[3]||(t[3]=(...e)=>l.FinishDocument&&l.FinishDocument(...e))},(0,m.zw)(i.translate.TR_YES),1),(0,s._)("p",{onClick:t[4]||(t[4]=e=>l.SetIsFinishing(!1))},(0,m.zw)(i.translate.TR_NO),1)])]))])),_:1},8,["title"])):(0,s.kq)("",!0),(0,s._)("div",cn,[(0,s.Wm)(c,{label:i.translate.TR_SEE_LIST},{default:(0,s.w5)((()=>[(0,s.Wm)(d,{to:"/home/documents"},{default:(0,s.w5)((()=>[(0,s.Uk)((0,m.zw)(i.translate.TR_BACK),1)])),_:1})])),_:1},8,["label"])]),(0,s._)("div",_n,[(0,s._)("div",un,[(0,s._)("div",mn,[(0,s._)("img",{src:i.document.infos?.banner,alt:""},null,8,Tn)]),(0,s._)("div",pn,[(0,s._)("div",null,[(0,s._)("p",null,(0,m.zw)(i.document.infos?.name_document),1),(0,s._)("p",null,(0,m.zw)(i.document.infos?.title),1)]),(0,s._)("div",null,[(0,s._)("p",null,(0,m.zw)(i.document.infos?.date),1),(0,s._)("p",null,(0,m.zw)(1==i.document.infos?.status?i.translate.TR_OPENNED:i.translate.TR_CLOSED),1)])])]),(0,s._)("div",gn,[(0,s.Wm)(d,{class:"option",to:{name:"editor",params:{id:i.document.id,type:"document",action:"edit"}}},{default:(0,s.w5)((()=>[hn,(0,s._)("p",null,(0,m.zw)(i.translate.TR_OPEN),1),En])),_:1},8,["to"]),1==i.document.infos.status?((0,s.wg)(),(0,s.iD)("div",{key:0,class:"option",onClick:t[6]||(t[6]=e=>l.SetIsFinishing(!0))},[fn,(0,s.Wm)(c,{label:i.translate.TR_FINISH_LABEL},{default:(0,s.w5)((()=>[(0,s._)("p",null,(0,m.zw)(i.translate.TR_FINISH),1)])),_:1},8,["label"]),vn])):((0,s.wg)(),(0,s.iD)("div",{key:1,class:"option",onClick:t[7]||(t[7]=(...e)=>l.CreateCopy&&l.CreateCopy(...e))},[wn,(0,s._)("p",null,(0,m.zw)(i.translate.TR_CREATE_COPY),1),Rn])),(0,s._)("div",{class:"option",onClick:t[8]||(t[8]=(...e)=>l.ShowDocument&&l.ShowDocument(...e))},[Dn,(0,s.Wm)(c,{label:i.translate.TR_SHOW_LABEL},{default:(0,s.w5)((()=>[(0,s._)("p",null,(0,m.zw)(i.translate.TR_SHOW_DOCUMENT),1)])),_:1},8,["label"]),Sn]),(0,s._)("div",{class:"option",onClick:t[9]||(t[9]=(...e)=>l.GiveDocument&&l.GiveDocument(...e))},[Cn,(0,s.Wm)(c,{label:i.translate.TR_GIVE_LABEL},{default:(0,s.w5)((()=>[(0,s._)("p",null,(0,m.zw)(i.translate.TR_GIVE_DOCUMENT),1)])),_:1},8,["label"]),yn]),(0,s._)("div",{class:"option",onClick:t[10]||(t[10]=e=>l.SetIsDeleting(!0))},[bn,(0,s._)("p",null,(0,m.zw)(i.translate.TR_DELETE),1),Ln])])])])}var In={components:{Modal:Ye,Loading:Ke},props:{id:{default:-1}},data(){return{is_deleting:!1,loading_delete:!1,save_error:!1,save_error_msg:"",is_finishing:!1,loading_finish:!1,document:{},wait:!1,translate:{}}},methods:{SetIsDeleting:function(e){this.is_deleting=e},SetLoadingDelete:function(e){this.loading_delete=e},CloseSave:function(){this.SetIsDeleting(!1),this.SetLoadingDelete(!1),this.SetIsFinishing(!1),this.SetLoadingFinish(!1)},DeleteDocument:function(){this.SendToClient("DeleteDocument",{document_id:this.id}),this.SetLoadingDelete(!0)},FinishDocument:function(){this.SendToClient("FinishDocument",{document_id:this.id}),this.SetLoadingFinish(!0)},SetIsFinishing:function(e){this.is_finishing=e},SetLoadingFinish:function(e){this.loading_finish=e},GiveDocument:function(){this.SendToClient("GiveDocument",{document_id:this.id})},ShowDocument:function(){this.SendToClient("ShowDocument",{document_id:this.id})},SendToClient:function(e,t){o().post(`https://${this.$store.state.name_resource}/${e}`,t).catch((t=>console.log(`An error has occurred (DocumentOptions): ${e} : ${t}`)))},CreateCopy:function(){this.wait||(this.SendToClient("CreateCopy",{document_id:this.id}),this.wait=!0)},ReceiveLua:function(e){if(!e||!e.data)return;const t=e.data;t.confirm_action?(this.wait=!1,this.$router.back()):t.cancel_action&&(this.save_error=!0,this.save_error_msg=t.cancel_msg,this.wait=!1)}},created:function(){this.translate=this.$store.state.translate,this.document=this.$store.getters.GetDocument(this.id),window.addEventListener("message",this.ReceiveLua)},unmounted:function(){window.removeEventListener("message",this.ReceiveLua)}};const An=(0,d.Z)(In,[["render",kn],["__scopeId","data-v-b5a66028"]]);var zn=An;const On=[{path:"/",redirect:"/home/documents"},{path:"/home",name:"home",component:R,children:[{path:"documents",name:"documents",component:ft},{path:"templates",name:"templates",component:Wt},{path:"options/:id",name:"options",component:zn,props:!0}]},{path:"/document/:action/:type/:id",name:"editor",component:Qe,props:!0}],Mn=(0,u.p7)({history:(0,u.r5)(),routes:On});var Nn=Mn,xn=n(65),$n=(0,xn.MT)({state:{translate:{TR_DOCUMENT_SYSTEM:"DOCUMENTS SYSTEM",TR_WELCOME:"Bem vindo de volta ao Gerenciamento de Documentos.",TR_WELCOME_TEXT:"Aqui você pode visualizar, editar e criar novos documentos.",TR_TITLE:"Document Title",TR_DATE:"April 16, 2020",TR_SUBTITLE:"YOUR TITLE",TR_CHOOSE_PHOTO:"Escolha uma foto",TR_PLACE_URL:"URL para a imagem",TR_LOAD:"Carregar",TR_CHANGE:"Trocar",TR_CANCEL:"Cancelar",TR_OR_PREVIEW:"Ou escolha uma já utilizada anteriormente",TR_SAVE_DOCUMENT:"Salvar Documento",TR_NAME_DOCUMENT:"Nome do Documento",TR_CONFIRM:"Confirmar",TR_TEMPLATE:"Template",TR_DOCUMENT:"Document",TR_BACK:"Voltar",TR_CHANGE_BANNER:"Alterar Logo",TR_ADD_SIG:"Adicionar Assinaturas",TR_DEL_SIG:"Remover Assinaturas",TR_SAVE:"Salvar",TR_TEXT_HERE:"YOUR TEXT HERE",TR_CREATED_BY:"created by",TR_UPDATED_BY:"updated by",TR_FINISH_BY:"finish by",TR_DELETE_IMG:"Deletar Imagem",TR_CLICK_IMG:"Clique para Inserir uma imagem",TR_TEXT_INSERT_IMG:"A URL deve ser segura (HTTPS) e conter .png , .jpg ou .gif",TR_PUT_URL:"Coloque uma URL",TR_INSERT:"Inserir",TR_EXAMPLE_NAME:"Example Name",TR_EXAMPLE_INFO:"Example Info",TR_DELETE_TITLE:"Tem certeza que deseja deletar este documento?",TR_DELETE_TEXT:"Ao excluir este documento, ele será apagado completamente, não sendo possível recuperá-lo. Você tem certeza disso?",TR_YES:"Sim",TR_NO:"Não",TR_EXIT:"Sair",TR_FINISH_TITLE:"Tem certeza que deseja Concluir este documento?",TR_FINISH_TEXT:"Ao Concluir este documento, Ele não poderá mais ser editado por ninguém. Você tem certeza disso?",TR_SAVING:"Salvando...",TR_SEE_LIST:"Ver lista de documentos",TR_OPENNED:"Aberto",TR_CLOSED:"Fechado",TR_OPEN:"Abrir",TR_FINISH_LABEL:"Após concluir, ninguém poderá editar",TR_FINISH:"Concluir Documento",TR_CREATE_COPY:"Criar Cópia",TR_SHOW_LABEL:"O jogador não poderá editar",TR_SHOW_DOCUMENT:"Mostrar para o Jogador mais Próximo",TR_GIVE_LABEL:"O jogador poderá editar",TR_GIVE_DOCUMENT:"Enviar para o Jogador mais Próximo",TR_DELETE:"Deletar",TR_CREATE_M_LABEL:"Crie um novo Modelo ou Documento",TR_NEW_DOCUMENT:"Novo Documento",TR_MY_DOCUMENTS:"Meus Documento",TR_SEARCH:"Procure por um documento",TR_EMPTY_DOCS:"Você não possui nenhum documento",TR_LOADING_DOCS:"Carregando Documentos",TR_DELETE_TITLE2:"Tem certeza que deseja deletar este template?",TR_DELETE_TEXT2:"Ao excluir este template, ele será apagado completamente, não sendo possível recuperá-lo. Você tem certeza disso?",TR_BACK_DOCUMENTS:"Voltar para lista de Documentos",TR_CREATE_TEMPLATE:"Crie um novo Modelo",TR_NEW_TEMPLATE:"Novo Modelo",TR_CHOOSE_TEMPLATE:"Escolha um Modelo",TR_CHOOSE_TEMPLATE2:"Escolher este Modelo",TR_EDIT_TEMPLATE:"Editar este Modelo",TR_DELETE_TEMPLATE:"Deletar este Modelo",TR_EMPTY_TEMPS:"Nenhum template encontrado",TR_LOADING_TEMPS:"Carregando Templates"},name_resource:"lg_documents",server_banner:"img/banner.png",documents:[],templates:[]},getters:{GetDocument:e=>t=>{const n=e.documents.filter((e=>e.id==t));return n[0]},GetTemplate:e=>t=>{const n=e.templates.filter((e=>e.id==t));return n[0]}},mutations:{SetDocuments(e,t){e.documents=t},SetTemplates(e,t){e.templates=t}},actions:{},modules:{}}),Pn=n(7638);(0,a.ri)(_).use(Pn.Z).use($n).use(Nn).mount("#app")}},t={};function n(a){var s=t[a];if(void 0!==s)return s.exports;var i=t[a]={exports:{}};return e[a](i,i.exports,n),i.exports}n.m=e,function(){var e=[];n.O=function(t,a,s,i){if(!a){var l=1/0;for(c=0;c<e.length;c++){a=e[c][0],s=e[c][1],i=e[c][2];for(var o=!0,r=0;r<a.length;r++)(!1&i||l>=i)&&Object.keys(n.O).every((function(e){return n.O[e](a[r])}))?a.splice(r--,1):(o=!1,i<l&&(l=i));if(o){e.splice(c--,1);var d=s();void 0!==d&&(t=d)}}return t}i=i||0;for(var c=e.length;c>0&&e[c-1][2]>i;c--)e[c]=e[c-1];e[c]=[a,s,i]}}(),function(){n.n=function(e){var t=e&&e.__esModule?function(){return e["default"]}:function(){return e};return n.d(t,{a:t}),t}}(),function(){n.d=function(e,t){for(var a in t)n.o(t,a)&&!n.o(e,a)&&Object.defineProperty(e,a,{enumerable:!0,get:t[a]})}}(),function(){n.g=function(){if("object"===typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(e){if("object"===typeof window)return window}}()}(),function(){n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)}}(),function(){var e={143:0};n.O.j=function(t){return 0===e[t]};var t=function(t,a){var s,i,l=a[0],o=a[1],r=a[2],d=0;if(l.some((function(t){return 0!==e[t]}))){for(s in o)n.o(o,s)&&(n.m[s]=o[s]);if(r)var c=r(n)}for(t&&t(a);d<l.length;d++)i=l[d],n.o(e,i)&&e[i]&&e[i][0](),e[i]=0;return n.O(c)},a=self["webpackChunkdocuments"]=self["webpackChunkdocuments"]||[];a.forEach(t.bind(null,0)),a.push=t.bind(null,a.push.bind(a))}();var a=n.O(void 0,[998],(function(){return n(4920)}));a=n.O(a)})();
//# sourceMappingURL=app.1c2c57b9.js.map