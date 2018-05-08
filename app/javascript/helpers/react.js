import React from 'react';
import PropTypes from 'prop-types';
import ModelCollection from '../models/model-collection';

const ModelCollectionType = PropTypes.instanceOf(ModelCollection);

export { React, PropTypes, ModelCollectionType };
export { observable, action, computed } from 'mobx';
export { observer } from 'mobx-react';
