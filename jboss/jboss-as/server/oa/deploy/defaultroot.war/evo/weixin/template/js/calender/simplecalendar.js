var calendar = {

	init: function(ajax, url) {

		if (ajax) {

      // ajax call to print json
      $.ajax({
  				url: url,
  				type: 'GET',
  				success: function(data) {
					 var data =eval("("+data+")");
  					 var events = data.events;

			          // loop json & append to dom
			          for (var i = 0; i < events.length; i++) {
			            $('.list').append('<div class="day-event" date-day="'+ events[i].day +'" date-month="' + events[i].month +'" date-year="'+ events[i].year +'" data-number="'+ i +'"><a href="#" class="close fontawesome-remove"></a><h2 class="title">'+ events[i].title +'</h2><p>'+ events[i].description +'</p><label class="check-btn"><input type="checkbox" class="save" id="save" name="" value=""/><span>Save to personal list!</span></label></div>');
			          }

			          // start calendar
			          calendar.startCalendar();		
  				}
  			});

		} else {

      // if not using ajax start calendar
      calendar.startCalendar();
    }

	},

  startCalendar: function() {
    var mon = 'Mon';
		var tue = 'Tue';
		var wed = 'Wed';
		var thur = 'Thu';
		var fri = 'Fir';
		var sat = 'Sat';
		var sund = 'Sun';

		/**
		 * Get current date
		 */
		var d = new Date();
		var strDate = yearNumber + "/" + (d.getMonth() + 1) + "/" + d.getDate();
		var yearNumber = (new Date).getFullYear();
		/**
		 * Get current month and set as '.current-month' in title
		 */
		var monthNumber = d.getMonth() + 1;

		function GetMonthName(monthNumber) {
			var months = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
			return months[monthNumber - 1];
		}

		setMonth(monthNumber, mon, tue, wed, thur, fri, sat, sund);

		function setMonth(monthNumber, mon, tue, wed, thur, fri, sat, sund) {
			$('.month').text(yearNumber +'年'+ GetMonthName(monthNumber));
			$('.month').attr('data-month', monthNumber);
			printDateNumber(monthNumber, mon, tue, wed, thur, fri, sat, sund);
		}

		$('.btn-next').on('click', function(e) {
			var monthNumber = $('.month').attr('data-month');
			if (monthNumber > 11) {
				$('.month').attr('data-month', '0');
				var monthNumber = $('.month').attr('data-month');
				yearNumber = yearNumber + 1;
				setMonth(parseInt(monthNumber) + 1, mon, tue, wed, thur, fri, sat, sund);
			} else {
				setMonth(parseInt(monthNumber) + 1, mon, tue, wed, thur, fri, sat, sund);
			};
			grayDate();//已安排会议的日期置灰
		});

		$('.btn-prev').on('click', function(e) {
			var monthNumber = $('.month').attr('data-month');
			if (monthNumber < 2) {
				$('.month').attr('data-month', '13');
				var monthNumber = $('.month').attr('data-month');
				yearNumber = yearNumber - 1;
				setMonth(parseInt(monthNumber) - 1, mon, tue, wed, thur, fri, sat, sund);
			} else {
				setMonth(parseInt(monthNumber) - 1, mon, tue, wed, thur, fri, sat, sund);
			};
			grayDate();//已安排会议的日期置灰
		}); 

		function printDateNumber(monthNumber, mon, tue, wed, thur, fri, sat, sund) {

			$($('tbody.event-calendar tr')).each(function(index) {
				$(this).empty();
			});

			$($('thead.event-days tr')).each(function(index) {
				$(this).empty();
			}); 

			// 设置日历头部为固定从周日开始：
			$('thead.event-days tr').append('<td>' + sund + '</td><td>' + mon + '</td><td>' + tue + '</td><td>' + wed + '</td><td>' + thur + '</td><td>' + fri + '</td><td>' + sat + '</td>');
		 
			// 设置日历的Body 部分，
			var monthDays = [];
			// 追加月头， 使之从周日开始
			(function(date){
				while (date.getDay() !== 0){
					date.setDate(date.getDate() -1);
					monthDays.unshift({
						year: date.getFullYear(),
						month: date.getMonth() + 1,
						date: date.getDate(),
						show: false
					});
				}
			})(new Date(yearNumber, monthNumber - 1, 1));

			//追加本月的数据
			(function(date){
				while (date.getMonth() === monthNumber -1) {
					monthDays.push({
						year: date.getFullYear(),
						month: date.getMonth() + 1,
						date: date.getDate(),
						show: true
					});
					date.setDate(date.getDate() + 1);
				}
			})(new Date(yearNumber, monthNumber -1 , 1));

			//追加月尾数据， 使之 一周六结尾
			(function (date) {
				while(date.getDay() !== 6){
					date.setDate(date.getDate() + 1);
					monthDays.push({
						year: date.getFullYear(),
						month: date.getMonth() + 1,
						date: date.getDate(),
						show: false
					});
				}
			})(new Date(yearNumber, monthNumber, 0));


			$.each(monthDays, function(index, item){ 
				$('tbody.event-calendar tr').eq(Math.floor(index / 7)).append('<td date-month="' + item.month + '" date-day="' + item.date + '" date-year="' + item.year + '"' +'id='+item.year+item.month+item.date+(item.show ? '': ' class="hidden-date"') + ' onclick="selectdate(this)"><span>' + item.date  + '</span></td>');
			})
 
			var date = new Date();
			var month = date.getMonth() + 1;
			var thisyear = new Date().getFullYear();
			setCurrentDay(month, thisyear);
			setEvent();
			// displayEvent();
		}

		/**
		 * Get current day and set as '.current-day'
		 */
		function setCurrentDay(month, year) {
			var viewMonth = $('.month').attr('data-month');
			var eventYear = $('.event-days').attr('date-year');
			if (parseInt(year) === yearNumber) {
				if (parseInt(month) === parseInt(viewMonth)) {
					$('tbody.event-calendar td[date-day="' + d.getDate() + '"]').addClass('current-day');
				}
			}
		};

		/**
		 * Add class '.active' on calendar date
		 */
		$('tbody td').on('click', function(e) {
			if ($(this).hasClass('event')) {
				$('tbody.event-calendar td').removeClass('active');
				$(this).addClass('active');
			} else {
				$('tbody.event-calendar td').removeClass('active');
			};
		});

		/**
		 * Add '.event' class to all days that has an event
		 */
		function setEvent() {
			$('.day-event').each(function(i) {
				var eventMonth = $(this).attr('date-month');
				var eventDay = $(this).attr('date-day');
				var eventYear = $(this).attr('date-year');
				var eventClass = $(this).attr('event-class');
				if (eventClass === undefined) eventClass = 'event';
				else eventClass = 'event ' + eventClass;

				if (parseInt(eventYear) === yearNumber) {
					$('tbody.event-calendar tr td[date-month="' + eventMonth + '"][date-day="' + eventDay + '"]').addClass(eventClass);
				}
			});
		};

		/**
		 * Get current day on click in calendar
		 * and find day-event to display
		 */
		// function displayEvent() {
		// 	$('tbody.event-calendar td').on('click', function(e) {
		// 		// $('.day-event').hide();
		// 		var monthEvent = $(this).attr('date-month');
		// 		var dayEvent = $(this).text();
		// 		$('.day-event[date-month="' + monthEvent + '"][date-day="' + dayEvent + '"]').show();
		// 	});
		// };

		/**
		 * Close day-event
		 */
		// $('.close').on('click', function(e) {
		// 	$(this).parent().slideUp('fast');
		// });

		/**
		 * Save & Remove to/from personal list
		 */
		// $('.save').click(function() {
		// 	if (this.checked) {
		// 		$(this).next().text('Remove from personal list');
		// 		var eventHtml = $(this).closest('.day-event').html();
		// 		var eventMonth = $(this).closest('.day-event').attr('date-month');
		// 		var eventDay = $(this).closest('.day-event').attr('date-day');
		// 		var eventNumber = $(this).closest('.day-event').attr('data-number');
		// 		$('.person-list').append('<div class="day" date-month="' + eventMonth + '" date-day="' + eventDay + '" data-number="' + eventNumber + '" style="display:none;">' + eventHtml + '</div>');
		// 		$('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"]').slideDown('fast');
		// 		$('.day').find('.close').remove();
		// 		$('.day').find('.save').removeClass('save').addClass('remove');
		// 		$('.day').find('.remove').next().addClass('hidden-print');
		// 		remove();
		// 		sortlist();
		// 	} else {
		// 		$(this).next().text('Save to personal list');
		// 		var eventMonth = $(this).closest('.day-event').attr('date-month');
		// 		var eventDay = $(this).closest('.day-event').attr('date-day');
		// 		var eventNumber = $(this).closest('.day-event').attr('data-number');
		// 		$('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').slideUp('slow');
		// 		setTimeout(function() {
		// 			$('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').remove();
		// 		}, 1500);
		// 	}
		// });

		// function remove() {
		// 	$('.remove').click(function() {
		// 		if (this.checked) {
		// 			$(this).next().text('Remove from personal list');
		// 			var eventMonth = $(this).closest('.day').attr('date-month');
		// 			var eventDay = $(this).closest('.day').attr('date-day');
		// 			var eventNumber = $(this).closest('.day').attr('data-number');
		// 			$('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').slideUp('slow');
		// 			$('.day-event[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').find('.save').attr('checked', false);
		// 			$('.day-event[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').find('span').text('Save to personal list');
		// 			setTimeout(function() {
		// 				$('.day[date-month="' + eventMonth + '"][date-day="' + eventDay + '"][data-number="' + eventNumber + '"]').remove();
		// 			}, 1500);
		// 		}
		// 	});
		// }

		/**
		 * Sort personal list
		 */
		// function sortlist() {
		// 	var personList = $('.person-list');

		// 	personList.find('.day').sort(function(a, b) {
		// 		return +a.getAttribute('date-day') - +b.getAttribute('date-day');
		// 	}).appendTo(personList);
		// }

		/**
		 * Print button
		 */
		// $('.print-btn').click(function() {
		// 	window.print();
		// });
  },

};