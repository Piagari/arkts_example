import { DialogMap, RouterModule, StringUtils } from '@ohos_agcit/office_attendance_common_lib';
import { BlankBackground, DateElement } from '@ohos_agcit/office_attendance_component_lib';
import { promptAction } from '@kit.ArkUI';
import { ScheduleInfo } from '../types/Types';
import { ScheduleForm } from './components/ScheduleForm';
import { Constants } from '../constants/Constants';


@Builder
export function newScheduleBuilder() {
  NewSchedule();
}

@Preview
@ComponentV2
export struct NewSchedule {
  @Provider() selectedDay: DateElement | undefined;
  @Provider() schedule: ScheduleInfo = {
    title: '',
    isAllDay: false,
    recurrenceRule: Constants.NO_REPEAT,
    reminderTime: [Constants.REMINDER_MINUTES_30],
    startTime: '',
    endTime: ''
  };

  aboutToAppear(): void {
    this.selectedDay = RouterModule.getNavParam({ url: DialogMap.NEW_SCHEDULE }).param as DateElement;
  }

  hide() {
    animateTo({
      duration: 300,
      curve: Curve.Friction,
      onFinish: () => {
        RouterModule.pop();
      },
    }, () => {
    });
  }

  save() {
    if (StringUtils.isBlank(this.schedule.title)) {
      promptAction.showToast({ message: $r('app.string.schedule_title_empty_tip') })
      this.getUIContext().getFocusController().requestFocus('titleID');
      return;
    }
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Bottom }) {
        /********弹框空背景***********/
        BlankBackground()

        ScheduleForm({
          titleResID: 'app.string.new_schedule',
          hide: () => {
            this.hide()
          }, save: () => {
            this.save();
          }
        });
      }
      .width('100%')
      .height('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
    }
    .mode(NavDestinationMode.DIALOG)
    .onBackPressed(() => {
      return false;
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .hideTitleBar(true)
  }
}
