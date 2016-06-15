# BasicTutorialView
This is a template to create an initial tutorial for your application. It allows you to create very quickly and without difficulty.

Template:

![alt tag](imageModel.png)


Files:

    1. Example for ios9: 
        This is a example project.

    2. BasicTutorialView for Swift2: 
        The files for use this template. you must move these files within your project.



How to use?

    1. Create a variable of type windowView():
            let window = windowView()

    2. Import images and create a array of images:
            let imagesArray = [String]()
            imagesArray = ["img1","img2","img3","img4"]

    3. Create a array of titles:
            let titlesArray = [String]()
            titlesArray = ["title of image 1","title of image 2","title of image 3","title of image 4"]

    4. instantiate object:
            window.modelTwo(self, arrayImages: self.imagesArray, arrayTitles: self.titlesArray)




