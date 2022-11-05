terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=4.67.3"
    }
  }
  required_version = ">= 1.0.0"
}

resource "oci_core_vcn" "example_vcn" {
    compartment_id = var.compartment_id
    display_name = "<vcn-display-name>"
    cidr_blocks = ["10.0.0.0/16"]
}

resource "oci_core_subnet" "example_subnet" {
    compartment_id = var.compartment_id
    display_name = "<subnet-display-name>"
    vcn_id = oci_core_vcn.example_vcn.id
    cidr_block = "10.0.0.0/24"
}
