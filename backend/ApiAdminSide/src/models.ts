interface Lead {
  name: string;
  price: number;
  _embedded: Embedded;
}

interface Contact {
  name: string;
  created_by?: number;
  tags_to_add?: { name: string }[];
}

interface Company {
  name: string;
  custom_fields_values: {
    field_code: string;
    values: { value: string; enum_code: string }[];
  }[];
}

interface Embedded {
  tags: Id[];
}

interface Id {
  id: number;
}
