module JuliaAcademyData

import Pkg

export datapath, activate

const COURSE = Ref("")

"""
    datapath(paths...)

Like [`joinpath`](@ref), but specifically for loading supplimentary data and scripts for JuliaAcademy notebooks.

The course must first be [`activate`](@ref)'d before calling this function.
"""
function datapath(paths...; course=COURSE[])
    isempty(course) && error("no course has been activated; be sure to execute the first cell of the notebook to initialize the lecture")
    return joinpath(dirname(@__DIR__), "courses", course, paths...)
end

"""
    activate(course)

Activate the Pkg environment for a JuliaAcademy course and set up the package for loading data for that course.
"""
function activate(course)
    COURSE[] = course
    isdir(datapath()) || error("course $course does not exist")
    Pkg.activate(datapath())
    Pkg.instantiate()
    return nothing
end

end # module
