

(function($) {
	$.fn.validationEngineLanguage = function() {};
	$.validationEngineLanguage = {
		newLang: function() {
			$.validationEngineLanguage.allRules = 	{"required":{    			// Add your regex rules here, you can take telephone as an example
						"regex":"none",
						"alertText":"* Este campo é obrigatório",
						"alertTextCheckboxMultiple":"* Por favor, escolha uma opção",
						"alertTextCheckboxe":"* Por favor, confirme esta seleção"},
					"length":{
						"regex":"none",
						"alertText":"*Entre ",
						"alertText2":" e ",
						"alertText3": " caracteres permitidos"},
					"maxCheckbox":{
						"regex":"none",
						"alertText":"* Número máximo de seleções excedido"},
					"minCheckbox":{
						"regex":"none",
						"alertText":"* Por favor, escolha ",
						"alertText2":" as opções"},
					"confirm":{
						"regex":"none",
						"alertText":"* Confirmação não bate"},
					"telephone":{
						"regex":"/^[0-9\-\(\)\ ]+$/",
						"alertText":"* Telefone inválido"},
					"email":{
						"regex":"/^[a-zA-Z0-9_\.\-]+\@([a-zA-Z0-9\-]+\.)+[a-zA-Z0-9]{2,4}$/",
						"alertText":"* Email inválido"},
					"date":{
            "regex":"/^[0-9]{4}\-\[0-9]{1,2}\-\[0-9]{1,2}$/",
            "alertText":"* Data inválida, deve estar no formato YYYY-MM-DD"},
          "onlyInteger":{
						"regex":"/^[0-9]+$/",
						"alertText":"* Somente números inteiros são permitidos"},
					"onlyNumber":{
						"regex":"/^[0-9\ ]+$/",
						"alertText":"* Somente números são permitidos"},
					"noSpecialCaracters":{
						"regex":"/^[0-9a-zA-Z]+$/",
						"alertText":"* Caracteres especiais não são permitidos"},
					"onlyLetter":{
						"regex":"/^[a-zA-Z\ \']+$/",
						"alertText":"* Somente letras são permitidas"}
					}
		}
	}
})(jQuery);

$(document).ready(function() {
	$.validationEngineLanguage.newLang()
});

