using MDSh5: read_mds
using SHA: bytes2hex, sha256, hmac_sha256
using Test

function calculate_sha256(filename::String)
    open(filename, "r") do f
        return bytes2hex(hmac_sha256(collect(codeunits("key_string")), f))
    end
end

if Sys.islinux()
    d3d_s = "117e6c7279278671214b002de7a96a22ca1016d0137cdaf06c19add8d72b5c9f"
    kstar_s = "d0adcd99e0703d6b37ea00f953d09dcd692e346f697650c4056064ff91f7844d"
elseif Sys.isapple()
    d3d_s = "f7986f398e645f386085314586d2ca06d560996669eb2a87e3e18f78ab83eb2e"
    kstar_s = "85a1d9d26a3cb1679649127f5ab291401c108b98973ade6fd4724e1ee7e0da50"
end

@testset "read_mds" begin
    d3d_data = read_mds(;
        config="$(@__DIR__)/../config_examples/d3d.yml",
        out_filename="D3D.h5",
    )
    @test d3d_s == calculate_sha256("D3D.h5")
    kstar_data = read_mds(;
        config="$(@__DIR__)/../config_examples/kstar.yml",
        out_filename="KSTAR.h5",
    )
    @test kstar_s == calculate_sha256("KSTAR.h5")
end
