Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	Для каждого СтрокаТЧ Из Состав Цикл
		Если ЗначениеЗаполнено(СтрокаТЧ.Старт) И ЗначениеЗаполнено(СтрокаТЧ.Статья) И ЗначениеЗаполнено(СтрокаТЧ.ПродолжительностьВЧасах) Тогда
			НоваяЗапись = Движения.Время.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяЗапись, СтрокаТЧ);
			НоваяЗапись.Период = СтрокаТЧ.Старт;
			НоваяЗапись.Время = СтрокаТЧ.ПродолжительностьВЧасах;
			КонецПериодаВключительно = СтрокаТЧ.Старт + СтрокаТЧ.ПродолжительностьВЧасах * 3600 - 1;
			Если День(СтрокаТЧ.Старт) <> День(КонецПериодаВключительно) Тогда
				НачалоЗавтра = НачалоДня(КонецПериодаВключительно);
				НоваяЗапись.Время = (НачалоЗавтра - СтрокаТЧ.Старт) / 3600;
				НоваяЗапись = Движения.Время.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяЗапись, СтрокаТЧ);
				НоваяЗапись.Период = НачалоЗавтра;
				НоваяЗапись.Время = (КонецПериодаВключительно - НачалоЗавтра + 1) / 3600;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

