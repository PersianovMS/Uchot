Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
//	СтандартнаяОбработка = Ложь;
//	НастройкиОтчёта = КомпоновщикНастроек.Настройки;//.ПолучитьНастройки();
//	ПП = НастройкиОтчёта.ПараметрыДанных.Элементы.Найти("ПервыйПроход");
//	ПП.Использование = Истина;
//	#Область ПОДГОТОВКА_ПУСТОЙ_ТАБЛИЦЫ_ДЛЯ_НАБОРДАННЫХОБЪЕКТ
//		ТабПустая = КомпоновкаДанныхСервер.НаборДанныхОбъектВыгрузитьКолонки(СхемаКомпоновкиДанных, "Общий.Финал");
//		НаборыДанныхОбъекты = Новый Структура;
//		НаборыДанныхОбъекты.Вставить("ТабИтог_", ТабПустая);
//	#КонецОбласти
//	#Область ЛИНЕЙНАЯ_СТРУКТУРА_И_ПОЛЬЗОВАТЕЛЬСКИЕ_НАСТРОЙКИ_ДЛЯ_ЭТАПА_1
//		НастройкиЭтапа1 = КомпоновщикНастроек.ПолучитьНастройки();
//		ФлагЭтапа1 = НастройкиЭтапа1.ПараметрыДанных.Элементы.Найти("ПервыйПроход");
//		ФлагЭтапа1.Значение = Истина;
//		ФлагЭтапа1.Использование = Истина;
//		ТекВыбор = НастройкиЭтапа1.Выбор;
//		ТекВыбор.Элементы.Очистить();
//		Для каждого ЭлементВыбора Из ТекВыбор.ДоступныеПоляВыбора.Элементы Цикл
//			ТекПоле = ЭлементВыбора.Поле;
//			стрПоле = СокрЛП(ТекПоле);
//			Если Найти(стрПоле, "Отбор") = 0 И стрПоле <> "ПараметрыДанных" И стрПоле <> "СистемныеПоля" Тогда
//				ТекВыбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных")).Поле = ТекПоле;//Новый ПолеКомпоновкиДанных(ЭлементВыбора.Поле);
//			КонецЕсли;
//		КонецЦикла;
//		КомпоновкаДанныхСервер.ДобавитьГруппировкуЛинейныйСписок(НастройкиЭтапа1.Структура, Истина);
//	#КонецОбласти
//	#Область ФОРМИРОВАНИЕ_ТАБЛИЦЫ_ДАННЫХ
//		ТабИтог = ВОЛНА_ОбщегоНазначенияВС.ТаблицаСКД(СхемаКомпоновкиДанных, НастройкиЭтапа1, Истина, НаборыДанныхОбъекты);
//		Колво = ТабИтог.Количество();
//		Если Колво > 0 И НЕ ЗначениеЗаполнено(ТабИтог[Колво - 1].Период) Тогда
//			ТабИтог.Удалить(ТабИтог[Колво - 1]);
//		КонецЕсли;
//		Если ТабИтог.Колонки.Найти("ОстатокПослеОперации") = Неопределено Тогда
//			ТабИтог.Колонки.Добавить("ОстатокПослеОперации", Новый ОписаниеТипов("Число",
//															 Новый КвалификаторыЧисла(15, 2, ДопустимыйЗнак.Любой)));
//		КонецЕсли;
//		#Область ОСТАТКИ
//			ДатаОстатков = НастройкиОтчёта.ПараметрыДанных.Элементы.Найти("Дата1").Значение;
//			Если ДатаОстатков = '00000000' Тогда
//				СооОстатков = Новый Соответствие;
//			Иначе
//				ДатаОстатков = ДатаОстатков - 1;
//				#Область ТЕКСТ_ЗАПРОСА
//					Запрос = Новый Запрос(
//							"ВЫБРАТЬ
//							|	ДеньгиОбороты.Кошелёк КАК Кошелёк,
//							|	ДеньгиОбороты.ПоступлениеОборот КАК ПоступлениеОборот
//							|ИЗ
//							|	РегистрНакопления.Деньги.Обороты(ДАТАВРЕМЯ(1, 1, 1), &ПараметрДата, , ) КАК ДеньгиОбороты");
//				#КонецОбласти
//				Запрос.УстановитьПараметр("ПараметрДата", ДатаОстатков);
//				СооОстатков = ВОЛНА_ОбщегоНазначенияВС.СтруктураИзКолонокТаблицы(Запрос.Выполнить().Выгрузить(), "Кошелёк", "ПоступлениеОборот", Истина);
//			КонецЕсли;
//			Для каждого Строчка Из ТабИтог Цикл
//				Если СооОстатков[Строчка.Кошелёк] = Неопределено Тогда
//					СооОстатков.Вставить(Строчка.Кошелёк, 0);
//				КонецЕсли;
//				Строчка.ОстатокПослеОперации = СооОстатков[Строчка.Кошелёк] + Строчка.Поступление;
//				СооОстатков.Вставить(Строчка.Кошелёк, Строчка.ОстатокПослеОперации);
//			КонецЦикла;
//		#КонецОбласти
//	#КонецОбласти
//	НаборыДанныхОбъекты.Вставить("ТабИтог_", ТабИтог);
//	ПП.Значение = Ложь;
//	ДанныеРасшифровки = Новый ДанныеРасшифровкиКомпоновкиДанных;
//	КомпоновщикМакетаХ = Новый КомпоновщикМакетаКомпоновкиДанных;
//	СКД = СхемаКомпоновкиДанных;
//	МакетХ = КомпоновщикМакетаХ.Выполнить(СКД, КомпоновщикНастроек.Настройки, ДанныеРасшифровки);
//	ПроцессорКомпоновкиДанныхХ = Новый ПроцессорКомпоновкиДанных;
//	ПроцессорКомпоновкиДанныхХ.Инициализировать(МакетХ, НаборыДанныхОбъекты, ДанныеРасшифровки, Истина);
//	ПроцВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
//	ПроцВывода.УстановитьДокумент(ДокументРезультат);
//	ДокументРезультат.Очистить();
//	ПроцВывода.Вывести(ПроцессорКомпоновкиДанныхХ, Истина);
////	ТабТест = ВОЛНА_ОбщегоНазначенияВС.ТаблицаСКД(СхемаКомпоновкиДанных, НастройкиОтчёта, Истина, НаборыДанныхОбъекты);
//	ПП.Использование = Ложь;
КонецПроцедуры
