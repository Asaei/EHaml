(function ($) {
	$.fn.EDNGenerateUrl = function (target_selector, replace_map) {
		var $source = $(this),
			$target,
			run_filter = function () {
				var input = $source.val(),
					input_length = input.length,
					i,
					output_string = '';

				for (i = 0; i < input_length; i++)
					if (typeof replace_map[input.charAt(i)] == 'string')
						output_string += replace_map[input.charAt(i)];
					else
						output_string += input.charAt(i);

				$target.val(output_string);
			};

		if (typeof target_selector == 'string')
			$target = $(target_selector);
		else if (target_selector instanceof jQuery)
			$target = target_selector;
		else
			return false;

		$source
			.keyup(run_filter)
			.change(run_filter);
	};
} (jQuery));
