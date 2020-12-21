import os
import numpy as np
import mitsuba

nenvmaps = ['normalizedEnvmap/autumn_forest_01_2k.hdr',
            'normalizedEnvmap/combination_room_2k.hdr',
		    'normalizedEnvmap/driving_school_2k.hdr',
	        'normalizedEnvmap/hansaplatz_2k.hdr',
		    'normalizedEnvmap/lenong_2_2k.hdr',
		    'normalizedEnvmap/lythwood_lounge_2k.hdr',
		    'normalizedEnvmap/mealie_road_2k.hdr',
		    'normalizedEnvmap/moonless_golf_2k.hdr',
		    'normalizedEnvmap/noon_grass_2k.hdr',
		    'normalizedEnvmap/photo_studio_01_2k.hdr',
		    'normalizedEnvmap/preller_drive_2k.hdr',
		    'normalizedEnvmap/snowy_park_01_2k.hdr']

envmaps = ['envmap/autumn_forest_01_2k.hdr',
            'envmap/combination_room_2k.hdr',
		    'envmap/driving_school_2k.hdr',
	        'envmap/hansaplatz_2k.hdr',
		    'envmap/lenong_2_2k.hdr',
		    'envmap/lythwood_lounge_2k.hdr',
		    'envmap/mealie_road_2k.hdr',
		    'envmap/moonless_golf_2k.hdr',
		    'envmap/noon_grass_2k.hdr',
		    'envmap/photo_studio_01_2k.hdr',
		    'envmap/preller_drive_2k.hdr',
		    'envmap/snowy_park_01_2k.hdr']

for i in range(12):

    s = envmaps[i]
    index = s.find('/')
    envName = s[index+1:index+3]
    print(s,index,envName)
    # Set the desired mitsuba variant
    mitsuba.set_variant('scalar_rgb')

    from mitsuba.core import Bitmap, Struct, Thread
    from mitsuba.core.xml import load_file

    # Absolute or relative path to the XML file
    filename = 'shape_bunny.xml'

    # Add the scene directory to the FileResolver's search path
    Thread.thread().file_resolver().append(os.path.dirname(filename))

    # Load the actual scene
    scene = load_file(filename, envmap=envmaps[i])

    # Call the scene's integrator to render the loaded scene
    scene.integrator().render(scene, scene.sensors()[0])

    # After rendering, the rendered data is stored in the film
    film = scene.sensors()[0].film()

    # Write out rendering as high dynamic range OpenEXR file
    # film.set_destination_file('output.exr')
    # film.develop()

    # Write out a tonemapped JPG of the same rendering
    bmp = film.bitmap(raw=True)
    bmp.convert(Bitmap.PixelFormat.RGB, Struct.Type.UInt8, srgb_gamma=True).write(envName + '.png')

    # Get linear pixel values as a numpy array for further processing
    bmp_linear_rgb = bmp.convert(Bitmap.PixelFormat.RGB, Struct.Type.Float32, srgb_gamma=False)
    image_np = np.array(bmp_linear_rgb)
    print(image_np.shape)
