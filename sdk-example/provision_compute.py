import oci

# Load your tenancy, user, etc. information
config = oci.config.from_file()

# Variables to fill in
compartment_id = "<compartment-id>" # Fill with your compartment OCID
image_id = "<image-id>" # Fill with the Oracle Linux 8 OCID for your region
subnet_id = "<subnet-id>" # Fill with your public subnet OCID
display_name = "<display-name>" # Fill with your display name

# Get first availability domain name
iam = oci.identity.IdentityClient(config)
availability_domain =  iam.list_availability_domains(compartment_id).data[0].name

# Package all settings together
launch_instance_details = oci.core.models.LaunchInstanceDetails(
    availability_domain=availability_domain,
    compartment_id=compartment_id,
    display_name=display_name,
    shape="VM.Standard.A1.Flex",
    shape_config=oci.core.models.LaunchInstanceShapeConfigDetails(
        ocpus=1, memory_in_gbs=6),
    source_details=oci.core.models.InstanceSourceViaImageDetails(
        image_id=image_id, source_type="image"),
    create_vnic_details=oci.core.models.CreateVnicDetails(
        assign_public_ip=True, subnet_id=subnet_id)
)

# Launch compute instance
compute = oci.core.ComputeClient(config)
compute.launch_instance(launch_instance_details)

