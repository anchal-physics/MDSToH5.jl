module MDSh5

using PythonCall: pyimport, @pyconst

export read_mds

"""
    read_mds(;
        shot_numbers::Union{Nothing, Int, String, Vector{T}}=nothing,
        trees::Union{
            Nothing,
            String,
            Vector{String},
            Dict{String, Union{String, Vector{String}}},
        }=nothing,
        point_names::Union{Nothing, String, Vector{String}}=nothing,
        server::Union{Nothing, String}=nothing,
        proxy_server::Union{Nothing, String}=nothing,
        resample::Union{Nothing, Tuple{Any}, Array{Any}, Dict{String, Float64}}=nothing,
        rescale::Union{
            Nothing,
            Int,
            Float64,
            Vector{Int},
            Vector{Float64},
            Dict{String, Union{Int, Float64}},
        }=nothing,
        out_filename::Union{Nothing, String}=nothing,
        reread_data::Bool=false,
        force_full_data_read::Bool=false,
        config::Union{Nothing, String, Dict{String, Any}}=nothing,
        leave_shots_tqdm::Bool=true,
    ) where {T <: Union{Int64, String}}

Read data from MDSPlus server for provided shot numbers, trees, and pointnames.

Input keyword arguments:

    shot_numbers: When String, the String is assumed to be in format:
                  "<start_shot_number> to <end_shot_number>" with to as the separator
                  word to give a range of shot numbers. Vector of mixed Int and String
                  can be provided.

    trees: If Vector then the length of this Vector should match length of Vector
           provided to `pointnames` argument for one-to-one mapping. Alternatively,
           this can be a Dict with tree name as keys and point names as values.

    point_names: If Vector, then the length of this Vector should match length of Vector
                 provided to `trees` arguments for one-to-one mapping.

    server: MDSPlus server in the format of username@ip_address:port . Note that it is
            assumed that your ssh configuration/VPN is setup to directly access this
            server in case any tunneling is required.

    proxy_server: Proxy server to use to tunnel through to the server. If
                  provided, the username part from server definition will be used to
                  ssh into the proxy server from where it assumed that you have access
                  to the MDSplus server. If the username for proxy-server is different,
                  add it as a prefix here with @. Default is Nothing.

    resample: If provided as Iterable, it should be in order start, stop, inc
              recommended to use dictionary input to ensure correct mapping.
              Dict structure
              (start-> start_time, stop-> stop_time, increment-> time_step)
              This argument resampels the data for this regular time spacing.

    rescale: Used for rescaling time axis of data before resampling query (if any).
             If Int or Float, same rescaling factor is applied across all `trees`.
             If Vector, length of this Vector must be same as length of `trees` Vector
                        for one to one mapping of rescaling factor to a particular tree.
             If Dict, each tree would get it's own rescaling factor. If a tree is not
                      present in this dictionary, rescaling factor will default to 1.
            Resampling factor gets multiplied with stored MDSPlus time axis data, thus
            for example, if time axis data for a tree is in ms, supply rescaling factor
            of 1e-3 to convert the downloaded data in seconds and resample in units of
            seconds.

    out_filename: If provided, downloaded data will be stored in this filename in
                  HDF5 format. Thus `.h5` extension should be provided.

    reread_data: If true, even if a pointname data is already present in `out_filename`,
                 it will be downloaded again and overwritten. Can be used if resample or
                 rescale is changed from previous download.

    force_full_data_read: If true, if resample attempt fails on a pointname,
                          full data reading will be attempted without resampling. This
                          is useful in cases where the pointname stores time dimension
                          in other than dim0 data field.

    config: If String, the configuration file in YAML format would be read to create the
            configuration dictionary. Use Dict if using in interactive mode.
            Configuration dictionary can have any of the above arguments present in it.
            Arguments provided by configuration dictionary are overridden by arguments
            directly provided to the function.

    leave_shots_tqdm: If true, the progress bar about shots read will be left in the output.
"""
function read_mds(;
    shot_numbers::Union{Nothing, Int, String, Vector{T}}=nothing,
    trees::Union{
        Nothing,
        String,
        Vector{String},
        Dict{String, Union{String, Vector{String}}},
    }=nothing,
    point_names::Union{Nothing, String, Vector{String}}=nothing,
    server::Union{Nothing, String}=nothing,
    proxy_server::Union{Nothing, String}=nothing,
    resample::Union{Nothing, Tuple{Any}, Array{Any}, Dict{String, Float64}}=nothing,
    rescale::Union{
        Nothing,
        Int,
        Float64,
        Vector{Int},
        Vector{Float64},
        Dict{String, Union{Int, Float64}},
    }=nothing,
    out_filename::Union{Nothing, String}=nothing,
    reread_data::Bool=false,
    force_full_data_read::Bool=false,
    config::Union{Nothing, String, Dict{String, Any}}=nothing,
    leave_shots_tqdm::Bool=true,
) where {T <: Union{Int64, String}}
    return @pyconst(pyimport("mdsh5").read_mds)(;
        shot_numbers,
        trees,
        point_names,
        server,
        proxy_server,
        resample,
        rescale,
        out_filename,
        reread_data,
        force_full_data_read,
        config,
        leave_shots_tqdm,
    )
end

end # module MDSh5
