version 1.0
task run_cellpose_nuclear {

	input {       
    	File image_path
        Int? diameter
        Float? flow_thresh
        Float? cell_prob_thresh
        String? model_type
        Int? segment_channel

    }

    command {python -m cellpose --image_path ${image_path} \
                                --pretrained_model ${model_type} \
                                --save_tif \
                                --verbose \
                                --use_gpu \
                                --diameter ${diameter} \
                                --flow_threshold ${flow_thresh} \
                                --cellprob_threshold ${cell_prob_thresh} \
                                --chan ${segment_channel} \
                                --savedir /cromwell_root/  \
                                --no_npy
             # hack to change asap 
             mv *_cp_masks.tif imageout.tif
    }

    output{
        File imageout="imageout.tif"
    }

    runtime {
        docker: "oppdataanalysis/cellpose:V1.0"
        memory: "100GB"
        maxRetries: 2
        disks: "local-disk 200 HDD"

    }
    
}