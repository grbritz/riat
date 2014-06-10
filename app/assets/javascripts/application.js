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
//= require bootstrap
//= require_tree .
$(document).ready(function(){
	var modules = {
		distantSupervisionExperiment : function(){
				$('.btn').button();

				var HTML_NAMESPACE = "#distant-supervision-experiment";
				var sentence = $(HTML_NAMESPACE + " .sentence").text().split(/\\"/).join("\"");
				$(HTML_NAMESPACE + " .sentence").html(sentenceToSpans(sentence));
				
				$(HTML_NAMESPACE + " .extent-hover").hover(function(){
					sentTokSpansForEntity($(this)).forEach(function(ele){
						ele.addClass("entity");
					});
				}, function(){
					sentTokSpansForEntity($(this)).forEach(function(ele){
						ele.removeClass("entity");
					});
				});

				function sentenceToSpans(sentence) {
					return textToTokSpans(sentence).map(function(tokObj) {
						return '<span data-range="'+ tokObj.range +'">'+tokObj.tok + '</span>';
					});
				}

				function textToTokSpans(text, charStart) {
					var charcount = (charStart) ? charStart : 0;
					return text.split(/([\ .,;:()'])/g).map(function(tok) {
						var obj = {
							range : charcount + "-" + (charcount+tok.length),
							tok : tok
						};
						charcount += tok.length;
						return obj;
					});
				}

				function sentTokSpansForEntity(element) {
					var tokens = textToTokSpans(element.text(), parseInt(element.data("range").split("-")[0]));
					return tokens.map(function(tokObj) {
						return $(HTML_NAMESPACE + ' .sentence span[data-range="' + tokObj.range +'"]');
					});
				}

				// Showing the ambiguity reason box when "not sure" is pressed
				$(HTML_NAMESPACE + " .toggle-element .btn").click(function(e){
					e.stopImmediatePropagation();
					$(this).button('toggle');
					
					var group = $(this).closest(".toggle-element");
					var eleToToggle = $(HTML_NAMESPACE + " ." + group.data("toggle_show"));
					if(group.find("input:checked").val() == group.data("toggle_value")) {
						eleToToggle.removeClass("hide");
					}
					else {
						eleToToggle.addClass("hide");
					}
				});
			
		}
	};

	$.each(modules, function(moduleName, moduleCode) {
		moduleCode();
	});
});