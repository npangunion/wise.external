#define CATCH_CONFIG_MAIN
#include <Catch.hpp>

#include <ExLib.hpp>

TEST_CASE("Window tests", "[ExampleLib]")
{
	using namespace ExLib;
	Window w{ 600, 400, "Test Window" };

	auto size = w.getWindowSize();

	REQUIRE(size.first == 600);
	REQUIRE(size.second == 400);
}