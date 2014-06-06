// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function(){
	var modules = {
		distantSupervisionExperiment : function(){
			var HTML_NAMESPACE = "#distant-supervision-experiment";
			var sentence = $(".sentence").text().split(/\\"/).join("\"");
			$(HTML_NAMESPACE + " .sentence").html(sentenceToSpans(sentence));
			
			$(HTML_NAMESPACE + " .extent-hover").hover(function(){
				sentTokSpansForEntity($(this)).forEach(function(ele){

					ele.addClass("extent-hover");
				});
			}, function(){
				sentTokSpansForEntity($(this)).forEach(function(ele){
					ele.removeClass("extent-hover");
				});
			});

			function sentenceToSpans(sentence) {
				return textToTokSpans(sentence).map(function(tokObj) {
					return '<span data-range="'+ tokObj.range +'">'+tokObj.tok + '</span>';
				}).join(" ");
			}

			function textToTokSpans(text, charStart) {
				var charcount = (charStart) ? charStart : 0;
				return text.split(/[\ .,;:()']/).map(function(tok) {
					var obj = {
						range : charcount + "-" + (charcount+tok.length),
						tok : tok
					};
					charcount += tok.length + 1;
					return obj;
				});
			}

			function sentTokSpansForEntity(element) {
				var tokens = textToTokSpans(element.text(), parseInt(element.data("range").split("-")[0]));


				return tokens.map(function(tokObj) {
					return $('span[data-range="' + tokObj.range +'"]');
				});
			}
		}
	};

	$.each(modules, function(moduleName, moduleCode) {
		moduleCode();
	});
});