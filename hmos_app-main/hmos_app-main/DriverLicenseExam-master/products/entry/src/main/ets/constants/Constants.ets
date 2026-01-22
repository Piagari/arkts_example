import { TabListItem, ServiceEntryItem, SwiperBanner, MineServiceItem, KEMUTabListItem } from '../types/Types';

export const TAB_LIST: TabListItem[] = [
  {
    label: $r('app.string.home_page'),
    icon: $r('app.media.ic_home'),
    iconChecked: $r('app.media.ic_home_checked'),
  },
  {
    label: $r('app.string.mine'),
    icon: $r('app.media.ic_mine'),
    iconChecked: $r('app.media.ic_mine_checked'),
  },
];

export const MINE_LIST:MineServiceItem[] = [

]

export const KEMUTAB_LIST: KEMUTabListItem[] = [
  {
    label: $r('app.string.subject_one')
  },
  {
    label: $r('app.string.subject_two')
  },
  {
    label: $r('app.string.subject_three')
  },
  {
    label: $r('app.string.subject_four')
  },
];


