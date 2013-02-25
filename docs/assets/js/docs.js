/**
 * fixed 
 */
KISSY.ready(function(S){
	var S = KISSY , D = S.DOM , E = S.Event ,
		win = window , doc = document ,
		nav = S.get('#J_SubNav') ,
		top = D.offset(nav).top - 20 ,
		getElementsByName = function(name, tag){
		    var returns = document.getElementsByName(name);
		    if(returns.length > 0) return returns;
		    returns = new Array();
		    var e = document.getElementsByTagName(tag);
		    for(var i = 0; i < e.length; i++){
		        if(e[i].getAttribute("name") == name){
		            returns[returns.length] = e[i];
		        }
		    }
		    return returns;
		} ,

		topList = [] ,
		currentNav = '' ,
		docHeight = D.height(doc) ;

	S.each(S.query('a' , nav) , function(item , index){
		var name = item.href.split('#')[1] ,
			el = getElementsByName(name , 'a')[0] ,
			top = 0 ;

		if(!el || !name || D.hasClass(D.parent(item , 'li'),'disable')) return ;

		if(index === 0) {
			currentNav = name ;
			D.addClass(D.parent(item , 'li') , 'active') ;
			topList.push([0 , currentNav , 0])
		}

		top = D.offset(el).top - 100 ;

		topList.push([top , name , index]) ;
	})

	topList.push([docHeight]) ;


	E.on(win , 'scroll' , function(){
		//设置fixed
		var scrollTop = D.scrollTop(doc) ; 
			
		scrollTop > top ? D.addClass(nav , 'navFixed') : D.removeClass(nav , 'navFixed');

		for(var i = 0 ; i < topList.length -1 ; i++){
			var item = topList[i] ;
			if(scrollTop > item[0] && scrollTop < topList[i+1][0] && currentNav != item[1]){
				S.each(S.query('li' , nav) , function(el , idx){
					D.removeClass(el , 'active') ;
					if(idx === item[2]) D.addClass(el , 'active') ;
				});
				currentNav = item[1] ;
				location.hash = currentNav ;
				break;
			}
		}

		//滚到末尾
		if(scrollTop == docHeight - D.viewportHeight() -70){
			S.each(S.query('li' , nav) , function(el , idx){
				D.removeClass(el , 'active') ;
				if(idx === topList[topList.length-2][2]) D.addClass(el , 'active') ;
			})
		}
	}) ;
})
