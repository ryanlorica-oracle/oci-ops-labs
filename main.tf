terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "oci" {
  region              = var.region
}

resource "oci_core_vcn" "example_vcn" {
  dns_label      = "examplevcn"
  cidr_block     = "172.16.0.0/20"
  compartment_id = var.compartment_id
  display_name   = "Example VCN"
}

resource "oci_core_subnet" "example_subnet_one" {
  vcn_id                      = oci_core_vcn.example_vcn.id
  cidr_block                  = "172.16.0.0/24"
  compartment_id              = var.compartment_id
  display_name                = "Example Subnet 1"
  prohibit_public_ip_on_vnic  = false
  dns_label                   = "exsubnetone"
}

resource "oci_core_subnet" "example_subnet_two" {
  vcn_id                      = oci_core_vcn.example_vcn.id
  cidr_block                  = "172.16.1.0/24"
  compartment_id              = var.compartment_id
  display_name                = "Example Subnet 2"
  prohibit_public_ip_on_vnic  = false
  dns_label                   = "exsubnettwo"
}
