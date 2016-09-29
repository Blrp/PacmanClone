//=============================================================================
// main.mm
//
// 3.2.1 (2011.01.26)
//
// http://plasmaworks.com/plasmacore
//
// Launcher for Mac Plasmacore.  Designed to easily allow custom native
// features to be added to Plasmacore - see the following web page for 
// more information:
//
//   http://plasmaworks.com/wiki/index.php/Custom_Native_Functionality
//
// The GoGo build system creates this file if it's missing, but it is (handily)
// NOT overwritten during an upgrade.
//
// ----------------------------------------------------------------------------
//
// Copyright 2008-2011 Plasmaworks LLC
//
// Licensed under the Apache License, Version 2.0 (the "License"); 
// you may not use this file except in compliance with the License. 
// You may obtain a copy of the License at 
//
//   http://www.apache.org/licenses/LICENSE-2.0 
//
// Unless required by applicable law or agreed to in writing, 
// software distributed under the License is distributed on an 
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
// either express or implied. See the License for the specific 
// language governing permissions and limitations under the License.
//
//=============================================================================
#include "plasmacore.h"

void MacCore_init();
void MacCore_configure();
void MacCore_main_loop();

void perform_custom_setup()
{
  // See: http://plasmaworks.com/wiki/index.php/Custom_Native_Functionality
}

void NativeLayer_sleep( int ms )
{
  // Kill time between update cycles for the given number of milliseconds.
  // Add custom tasks as desired.
  [NSThread sleepForTimeInterval:(ms/1000.0)];
}


int main(int argc, char *argv[])
{
  try
  {
    MacCore_init();

    perform_custom_setup();

    MacCore_configure();
    MacCore_main_loop();
  }
  catch (int error_code)
  {
    if (slag_error_message.value) NativeLayer_alert( slag_error_message.value );
    NativeLayer_shut_down();
    SDL_Quit();
    return error_code;
  }
  catch ( const char* mesg )
  {
    NativeLayer_alert( mesg );
    SDL_Quit();
    return 1;
  }

  // Cleanup
  NativeLayer_shut_down();
  SDL_Quit();

  return 0;
}

