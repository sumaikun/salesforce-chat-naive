package com.fleettest;

import android.app.Activity;
import android.os.Bundle;

import com.facebook.react.ReactActivity;

public class MainActivity extends ReactActivity {
  private static Activity mCurrentActivity = null;
  /**
   * Returns the name of the main component registered from JavaScript. This is used to schedule
   * rendering of the component.
   */
  @Override
  protected String getMainComponentName() {
    return "fleetTest";
  }

  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    mCurrentActivity = this;
    System.out.println("native log: on create function");
  }

  public static Activity getActivity(){
    Activity activity = new Activity();
    activity = mCurrentActivity;
    return activity;
  }

}
