#include <ExLib.hpp>

#if defined _WIN32
        // OpenGL on Windows needs Windows.h
	#include <Windows.h>
#endif

#include <gl/GL.h>

int main()
{
	using namespace ExLib;
	Window window{ 800, 600, "Hello World!" };

	while (!window.shouldClose())
	{
		window.pollEvents();
		
		// Please note: this is old, OpenGL 1.1 code. It's here for simplicity.
		glBegin(GL_TRIANGLES);
			glVertex2f(-0.5f, -0.5f);
			glVertex2f(0.5f, -0.5f);
			glVertex2f(0, 0.5f);
		glEnd();

		window.swapBuffers();
	}

	return 0;
}