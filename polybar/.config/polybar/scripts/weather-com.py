import json
import weathercom

somelist = {}

icons_list = {
    "01d": "", # Clear sky day.
    "01n": "", # Clear sky night.
    "02d": "", # Few clouds day.
    "02n": "", # Few clouds night.
    "03d": "", # Scattered clouds day.
    "03n": "", # Scattered clouds night.
    "04d": "", # Broken clouds day.
    "04n": "", # Broken clouds night.
    "09d": "", # Shower rain day.
    "09n": "", # Shower rain night.
    "10d": "", # Rain day.
    "10n": "", # Rain night
    "11d": "", # Thunderstorm day.
    "11n": "", # Thunderstorm night
    "13d": "", # Snow day. Snowflake alternative: 
    "13n": "", # Snow night. Snowflake alternative: 
    "50d": "", # Mist day.
    "50n": "" # Mist night.
}

atmophere_icons_list = {
    701: "", # Mist
    711: "", # Smoke
    721: "", # Haze
    731: "", # Dust (Sand / dust whirls)
    741: "", # Fog
    751: "", # Sand
    761: "", # Dust
    762: "", # Ash
    771: "", # Squalls
    781: ""  # Tornado
}

def main():
    try:
        # Get data from weather.com
        weather = weathercom.getCityWeatherDetails("polotsk")
        data = json.loads(weather)
  
        # Get info from array
        id = data['vt1observation']['icon']
        icon = id
        temperature = data['vt1observation']['temperature']
        wind_speed = data['vt1observation']['windSpeed']


        return '%{F#3F5360}|%{F-} %{F${colors.foreground}' + ' {}°C'.format(temperature) + '%{F-}'
    except Exception as err:
        return "" # Return reload icon

if __name__ == "__main__":
	print(main())
