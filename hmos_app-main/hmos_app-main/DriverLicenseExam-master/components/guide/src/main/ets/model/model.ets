
export enum DRIVE_STAGE {
  SUBJECT_ONE = 1,
  SUBJECT_TWO = 2,
  SUBJECT_THREE = 3,
  SUBJECT_FOUR = 4
}

export enum  LICENSE_TYPE {
  CAR = 1,
  MOTORCYCLE = 2,
  TRUCK = 3,
  BUS = 4,
  LIGHT_TRUCK = 5
}

export const licenseTypeName:Record<LICENSE_TYPE, Resource> = {
  1: $r('app.string.little_car'),
  2: $r('app.string.motorcycles'),
  3: $r('app.string.truck'),
  4: $r('app.string.bus'),
  5: $r('app.string.light_truck')
}

@ObservedV2
export class  GuideData {
  @Trace city: string = '北京'
  @Trace licenseType: LICENSE_TYPE | undefined = undefined;
  @Trace driveStage: DRIVE_STAGE | undefined = undefined;

  private static _instance: GuideData;

  public static get instance() {
    if (!GuideData._instance) {
      GuideData._instance = new GuideData();
    }
    return GuideData._instance;
  }

}

export interface LICENSE_CARD {
  icon:Resource,
  name:Resource,
  description: string,
  value: LICENSE_TYPE,
  width?: number,
}

export const LICENSE_LIST_ONE:LICENSE_CARD [] = [
  {
    icon:$r('app.media.car'),
    name:$r('app.string.little_car'),
    description: 'C1/C2/C3',
    value:LICENSE_TYPE.CAR,
  },
  {
    icon:$r('app.media.motorcycles'),
    name:$r('app.string.motorcycles'),
    description: 'D/E/F',
    value: LICENSE_TYPE.MOTORCYCLE,
    width: 121
  }
]

export const LICENSE_LIST_TWO:LICENSE_CARD [] = [
  {
    icon:$r('app.media.truck'),
    name:$r('app.string.truck'),
    description: 'A2/B2',
    value: LICENSE_TYPE.TRUCK,
  },
  {
    icon:$r('app.media.bus'),
    name:$r('app.string.bus'),
    description: 'A2/B2',
    value: LICENSE_TYPE.BUS,
  },
  {
    icon:$r('app.media.light_truck'),
    name:$r('app.string.light_truck'),
    description: 'C6',
    value: LICENSE_TYPE.LIGHT_TRUCK
  }
]