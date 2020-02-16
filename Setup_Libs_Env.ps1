# change path appropriate for each user

$WISE_EXT_HOME = "E:\wisemountain\wise.external\libs\"

# Set boost home
[Environment]::SetEnvironmentVariable("BOOST_HOME", $WISE_EXT_HOME + "boost_1_72_0", "User")

# Set catch home 
[Environment]::SetEnvironmentVariable("CATCH_HOME", $WISE_EXT_HOME + "Catch2-2.11.1", "User")

# Set GLFW home
[Environment]::SetEnvironmentVariable("GLFW_HOME", $WISE_EXT_HOME + "glfw-3.3.2", "User")


# Set LIBSODIUM home
[Environment]::SetEnvironmentVariable("LIBSODIUM_HOME", $WISE_EXT_HOME + "libsodium-1.0.18-RELEASE", "User")

# Set SPDLOG home
[Environment]::SetEnvironmentVariable("SPDLOG_HOME", $WISE_EXT_HOME + "spdlog-1.5.0", "User")


# Set RECAST home
[Environment]::SetEnvironmentVariable("RECAST_HOME", $WISE_EXT_HOME + "recastnavigation", "User")
