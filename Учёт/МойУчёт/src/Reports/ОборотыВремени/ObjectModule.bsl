Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	ПарДан = КомпоновщикНастроек.Настройки.ПараметрыДанных;
	ЭлПД = ПарДан.Элементы;
	ЭлПН = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы;
	ПродолжительностьПериода = ЗначНастройки(ЭлПН, ЭлПД, "ПродолжительностьПериода");
	ИнтервалМеждуПериодами = ЗначНастройки(ЭлПН, ЭлПД, "ИнтервалМеждуПериодами");
	Если ПродолжительностьПериода.Использование И ЗначениеЗаполнено(ПродолжительностьПериода.Значение)
			И ИнтервалМеждуПериодами.Использование И ЗначениеЗаполнено(ИнтервалМеждуПериодами.Значение) Тогда
		ТипСрока = ЗначНастройки(ЭлПН, ЭлПД, "ТипСрока").Значение;
		Если НЕ ЗначениеЗаполнено(ТипСрока) Тогда
			ТипСрока = "Месяц";
		КонецЕсли;
		Дата41 = ЗначНастройки(ЭлПН, ЭлПД, "Дата41");
		Дата42 = ЗначНастройки(ЭлПН, ЭлПД, "Дата42");
		Дата11 = ЗначНастройки(ЭлПН, ЭлПД, "Дата11");
		СекВДне = 24 * 3600;
		Если ЗначениеЗаполнено(Дата41.Значение) Тогда
			Дата_41 = ?(ТипЗнч(Дата41.Значение) = Тип("Дата"), Дата41.Значение, Дата41.Значение.Дата);
			Дата11.Значение = ?(ТипСрока = "День",
					Дата_41 - 3 * ИнтервалМеждуПериодами.Значение * СекВДне,
					ДобавитьМесяц(Дата_41, -3 * ИнтервалМеждуПериодами.Значение));
		ИначеЕсли ЗначениеЗаполнено(Дата42.Значение) Тогда
			Дата_42 = ?(ТипЗнч(Дата42.Значение) = Тип("Дата"), Дата42.Значение, Дата42.Значение.Дата);
			Дата11.Значение = ?(ТипСрока = "День",
					Дата_42	- (3 * ИнтервалМеждуПериодами.Значение + ПродолжительностьПериода.Значение) * СекВДне,
					ДобавитьМесяц(Дата_42, -ПродолжительностьПериода.Значение - 3 * ИнтервалМеждуПериодами.Значение)) + 1;
		КонецЕсли;
		Если ЗначениеЗаполнено(Дата11.Значение) Тогда
			Дата12 = ЗначНастройки(ЭлПН, ЭлПД, "Дата12");
			Дата21 = ЗначНастройки(ЭлПН, ЭлПД, "Дата21");
			Дата22 = ЗначНастройки(ЭлПН, ЭлПД, "Дата22");
			Дата31 = ЗначНастройки(ЭлПН, ЭлПД, "Дата31");
			Дата32 = ЗначНастройки(ЭлПН, ЭлПД, "Дата32");
			Если ТипСрока = "День" Тогда
				Дата12.Значение = Дата11.Значение + ПродолжительностьПериода.Значение * СекВДне - 1;
				Дата21.Значение = Дата11.Значение + ИнтервалМеждуПериодами.Значение * СекВДне;
				Дата22.Значение = Дата12.Значение + ИнтервалМеждуПериодами.Значение * СекВДне;
				Дата31.Значение = Дата21.Значение + ИнтервалМеждуПериодами.Значение * СекВДне;
				Дата32.Значение = Дата22.Значение + ИнтервалМеждуПериодами.Значение * СекВДне;
				Дата41.Значение = Дата31.Значение + ИнтервалМеждуПериодами.Значение * СекВДне;
				Дата42.Значение = Дата32.Значение + ИнтервалМеждуПериодами.Значение * СекВДне;
			Иначе
				Дата21.Значение = ДобавитьМесяц(Дата11.Значение, ИнтервалМеждуПериодами.Значение);
				Дата31.Значение = ДобавитьМесяц(Дата11.Значение, 2 * ИнтервалМеждуПериодами.Значение);
				Дата41.Значение = ДобавитьМесяц(Дата11.Значение, 3 * ИнтервалМеждуПериодами.Значение);
				Дата12.Значение = ДобавитьМесяц(Дата11.Значение, ПродолжительностьПериода.Значение) - 1;
				Дата22.Значение = ДобавитьМесяц(Дата21.Значение, ПродолжительностьПериода.Значение) - 1;
				Дата32.Значение = ДобавитьМесяц(Дата31.Значение, ПродолжительностьПериода.Значение) - 1;
				Дата42.Значение = ДобавитьМесяц(Дата41.Значение, ПродолжительностьПериода.Значение) - 1;
			КонецЕсли;
			Дата11.Использование = Истина;
			Дата12.Использование = Истина;
			Дата21.Использование = Истина;
			Дата22.Использование = Истина;
			Дата31.Использование = Истина;
			Дата32.Использование = Истина;
			Дата41.Использование = Истина;
			Дата42.Использование = Истина;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

Функция  ЗначНастройки(ЭлПН, ЭлПД, ИмяНастройки)
	ОсновнойПараметр = ЭлПД.Найти(ИмяНастройки);
	Результат = ЭлПН.Найти(ОсновнойПараметр.ИдентификаторПользовательскойНастройки);
	Если Результат = Неопределено Тогда
		Результат = ОсновнойПараметр;
	КонецЕсли;
	Возврат Результат
КонецФункции // 

