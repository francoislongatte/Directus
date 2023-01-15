import { defineDisplay } from '@directus/extensions-sdk';
import DisplayComponent from './display.vue';

export default defineDisplay({
	id: 'TEst',
	name: 'test',
	icon: 'box',
	description: 'This is my custom display!',
	component: DisplayComponent,
	options: null,
	types: ['string'],
});
